set -ex

main() {
    local svd=STMicro/STM32F429.svd

    cargo check

    # check than the patch can be applied to the original SVD
    local url=https://github.com/posborne/cmsis-svd/raw/python-0.4/data/$svd
    local td=$(mktemp -d)
    local svd=$(basename $svd)
    local patch="${svd%.*}.patch"
    curl -LO $url
    dos2unix $svd
    patch -p1 $svd < $patch

    rm -rf $td
}

main
