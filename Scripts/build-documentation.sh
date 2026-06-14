#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DOCS_DIR="$REPO_ROOT/.docs"
DERIVED_DATA_DIR="$DOCS_DIR/DerivedData"
BUILD_DIR="$DOCS_DIR/build"
DOCC_OUTPUT_DIR="$BUILD_DIR/docc-output"
PREVIEW_ROOT="$BUILD_DIR/preview-root"

SCHEME_NAME="ScreenShieldKit"
DESTINATION="generic/platform=iOS Simulator"
HOSTING_BASE_PATH=""
SOURCE_SERVICE="github"
SOURCE_SERVICE_BASE_URL="https://github.com/Kyle-Ye/ScreenShieldKit/blob/main"
CLEAN_BUILD=false
PREVIEW_MODE=false
PREVIEW_PORT=8000
PREVIEW_HOST="127.0.0.1"

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Build ScreenShieldKit documentation using DocC.

OPTIONS:
    --preview                    Start a local preview server after building
    --port PORT                  Preview server port (default: 8000)
    --scheme NAME                Scheme to document (default: ScreenShieldKit)
    --destination DESTINATION    xcodebuild destination (default: generic/platform=iOS Simulator)
    --hosting-base-path PATH     Base path for GitHub Pages hosting
    --source-service SERVICE     Source service (github, gitlab, bitbucket)
    --source-service-base-url URL
                                 Base URL for source links
    --clean                      Remove previous documentation build artifacts
    -h, --help                   Show this help message

ENVIRONMENT:
    DOCC_HTML_DIR                Use an existing swift-docc-render dist directory.
                                 When unset, DocC uses its bundled renderer.
EOF
}

log_info() {
    echo "[INFO] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

rundocc() {
    if command -v xcrun >/dev/null 2>&1; then
        xcrun docc "$@"
    else
        docc "$@"
    fi
}

configure_docc_renderer() {
    if [[ -n "${DOCC_HTML_DIR:-}" ]]; then
        [[ -d "$DOCC_HTML_DIR" ]] || {
            log_error "DOCC_HTML_DIR does not exist: $DOCC_HTML_DIR"
            exit 1
        }
        export DOCC_HTML_DIR
        log_info "Using DocC renderer: $DOCC_HTML_DIR"
    else
        log_info "DocC renderer: bundled default"
    fi
}

preview_path() {
    if [[ -n "$HOSTING_BASE_PATH" ]]; then
        echo "${HOSTING_BASE_PATH%/}/documentation/screenshieldkit/"
    else
        echo "/documentation/screenshieldkit/"
    fi
}

start_preview_server() {
    command -v python3 >/dev/null 2>&1 || {
        log_error "python3 is required for preview mode"
        exit 1
    }

    if lsof -Pi :"$PREVIEW_PORT" -sTCP:LISTEN -t >/dev/null 2>&1; then
        log_error "Port $PREVIEW_PORT is already in use. Pass --port to choose another port."
        exit 1
    fi

    local serve_dir="$DOCC_OUTPUT_DIR"
    if [[ -n "$HOSTING_BASE_PATH" ]]; then
        local mount_path="${HOSTING_BASE_PATH#/}"
        rm -rf "$PREVIEW_ROOT"
        mkdir -p "$PREVIEW_ROOT"
        ln -s "$DOCC_OUTPUT_DIR" "$PREVIEW_ROOT/$mount_path"
        serve_dir="$PREVIEW_ROOT"
    fi

    local preview_url="http://${PREVIEW_HOST}:${PREVIEW_PORT}$(preview_path)"
    log_info "Preview URL: $preview_url"
    log_info "Press Ctrl+C to stop the preview server"
    (
        cd "$serve_dir"
        python3 -m http.server "$PREVIEW_PORT" --bind "$PREVIEW_HOST"
    )
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --preview)
            PREVIEW_MODE=true
            shift
            ;;
        --port)
            PREVIEW_PORT="$2"
            shift 2
            ;;
        --scheme)
            SCHEME_NAME="$2"
            shift 2
            ;;
        --destination)
            DESTINATION="$2"
            shift 2
            ;;
        --hosting-base-path)
            HOSTING_BASE_PATH="$2"
            shift 2
            ;;
        --source-service)
            SOURCE_SERVICE="$2"
            shift 2
            ;;
        --source-service-base-url)
            SOURCE_SERVICE_BASE_URL="$2"
            shift 2
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

if [[ -n "$SOURCE_SERVICE" && -z "$SOURCE_SERVICE_BASE_URL" ]]; then
    log_error "--source-service requires --source-service-base-url"
    exit 1
fi

if [[ -z "$SOURCE_SERVICE" && -n "$SOURCE_SERVICE_BASE_URL" ]]; then
    log_error "--source-service-base-url requires --source-service"
    exit 1
fi

command -v xcodebuild >/dev/null 2>&1 || {
    log_error "xcodebuild is required but not installed"
    exit 1
}

if ! command -v docc >/dev/null 2>&1 && ! command -v xcrun >/dev/null 2>&1; then
    log_error "docc is required but not found"
    exit 1
fi

if [[ "$CLEAN_BUILD" == true ]]; then
    log_info "Cleaning documentation build artifacts..."
    rm -rf "$DOCS_DIR"
fi

mkdir -p "$BUILD_DIR"
configure_docc_renderer

log_info "Configuration:"
log_info "  Scheme: $SCHEME_NAME"
log_info "  Destination: $DESTINATION"
if [[ -n "$HOSTING_BASE_PATH" ]]; then
    log_info "  Hosting base path: $HOSTING_BASE_PATH"
fi
if [[ "$PREVIEW_MODE" == true ]]; then
    log_info "  Preview port: $PREVIEW_PORT"
fi
if [[ -n "$SOURCE_SERVICE" ]]; then
    log_info "  Source service: $SOURCE_SERVICE"
    log_info "  Source service base URL: $SOURCE_SERVICE_BASE_URL"
fi

OTHER_DOCC_FLAGS=()
if [[ -n "$SOURCE_SERVICE" ]]; then
    OTHER_DOCC_FLAGS+=(
        --source-service "$SOURCE_SERVICE"
        --source-service-base-url "$SOURCE_SERVICE_BASE_URL"
        --checkout-path "$REPO_ROOT"
    )
fi

XCODEBUILD_ARGS=(
    docbuild
    -scheme "$SCHEME_NAME"
    -destination "$DESTINATION"
    -derivedDataPath "$DERIVED_DATA_DIR"
    -skipPackagePluginValidation
    -skipMacroValidation
)

if [[ ${#OTHER_DOCC_FLAGS[@]} -gt 0 ]]; then
    XCODEBUILD_ARGS+=("OTHER_DOCC_FLAGS=${OTHER_DOCC_FLAGS[*]}")
fi

log_info "Building documentation archive..."
(
    cd "$REPO_ROOT"
    xcodebuild "${XCODEBUILD_ARGS[@]}"
)

ARCHIVE_PATH="$(find "$DERIVED_DATA_DIR/Build/Products" -type d -name "${SCHEME_NAME}.doccarchive" -print -quit)"
if [[ -z "$ARCHIVE_PATH" ]]; then
    log_error "Could not find ${SCHEME_NAME}.doccarchive under $DERIVED_DATA_DIR"
    exit 1
fi

rm -rf "$DOCC_OUTPUT_DIR"

TRANSFORM_ARGS=(
    process-archive
    transform-for-static-hosting
    "$ARCHIVE_PATH"
    --output-path "$DOCC_OUTPUT_DIR"
)

if [[ -n "$HOSTING_BASE_PATH" ]]; then
    TRANSFORM_ARGS+=(--hosting-base-path "$HOSTING_BASE_PATH")
fi

log_info "Transforming documentation archive for static hosting..."
rundocc "${TRANSFORM_ARGS[@]}"

log_info "Documentation built successfully"
log_info "Documentation output: $DOCC_OUTPUT_DIR"

if [[ "$PREVIEW_MODE" == true ]]; then
    start_preview_server
fi
