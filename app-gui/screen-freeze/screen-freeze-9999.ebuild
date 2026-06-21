EAPI=8

inherit git-r3

DESCRIPTION="Screen freeze utility"
HOMEPAGE="https://github.com/Cynthion21x/screen-freeze"
EGIT_REPO_URI="https://github.com/Cynthion21x/screen-freeze.git"
EGIT_BRANCH="main"
EGIT_SUBMODULES=( "*" )

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
    dev-libs/wayland
"
RDEPEND="${DEPEND}"

src_compile() {

    emake -C raylib/src \
        PLATFORM=PLATFORM_DESKTOP \
        GLFW_LINUX_ENABLE_WAYLAND=TRUE \
        GLFW_LINUX_ENABLE_X11=FALSE \
        RAYLIB_MODULE_AUDIO=FALSE \
        RAYLIB_MODULE_MODELS=FALSE

    gcc ${CFLAGS} main.c \
        ./raylib/src/libraylib.a \
        -lm -lwayland-client \
        -o screen-freeze
}

src_install() {
    dobin screen-freeze
}
