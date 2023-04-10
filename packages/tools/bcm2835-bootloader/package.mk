# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="1.20220308"
PKG_SHA256="906fcce9e3908c1490d8e7ce09445accd72d17112c9c13d285ae5d186531c7d3"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="https://github.com/raspberrypi/firmware/archive/refs/tags/${PKG_VERSION}_buster.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
    cp -PRv boot/LICENCE* ${INSTALL}/usr/share/bootloader
    cp -PRv boot/bootcode.bin ${INSTALL}/usr/share/bootloader/bootcode.bin
    if [ "${DEVICE}" = "RPi4" ]; then
      cp -PRv boot/fixup4x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
      cp -PRv boot/start4x.elf ${INSTALL}/usr/share/bootloader/start.elf
    else
      cp -PRv boot/fixup_x.dat ${INSTALL}/usr/share/bootloader/fixup_x.dat
      cp -PRv boot/start_x.elf ${INSTALL}/usr/share/bootloader/start_x.elf
      cp -PRv boot/fixup.dat ${INSTALL}/usr/share/bootloader/fixup.dat
      cp -PRv boot/start.elf ${INSTALL}/usr/share/bootloader/start.elf
    fi

    find_file_path bootloader/update.sh ${PKG_DIR}/files/update.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path bootloader/canupdate.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    find_file_path config/distroconfig.txt ${PKG_DIR}/files/distroconfig.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path config/distroconfig-composite.txt ${PKG_DIR}/files/distroconfig-composite.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path config/config.txt ${PKG_DIR}/files/config.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
}
