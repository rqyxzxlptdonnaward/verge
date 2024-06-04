package=libxcb
$(package)_version=1.17.0
$(package)_download_path=https://xcb.freedesktop.org/dist
$(package)_file_name=libxcb-$($(package)_version).tar.gz
$(package)_sha256_hash=2c69287424c9e2128cb47ffe92171e10417041ec2963bceafb65cb3fcf8f0b85
$(package)_dependencies=xcb_proto libXau
$(package)_patches = remove_pthread_stubs.patch

define $(package)_set_vars
$(package)_config_opts=--disable-static --disable-devel-docs --without-doxygen --without-launchd
$(package)_config_opts += --disable-dependency-tracking --enable-option-checking
# Disable unneeded extensions.
# More info is available from: https://doc.qt.io/qt-6.5/linux-requirements.html
$(package)_config_opts += --disable-composite --disable-damage --disable-dpms
$(package)_config_opts += --disable-dri2 --disable-dri3 --disable-glx
$(package)_config_opts += --disable-present --disable-record --disable-resource
$(package)_config_opts += --disable-screensaver --disable-xevie --disable-xfree86-dri
$(package)_config_opts += --disable-xinput --disable-xprint --disable-selinux
$(package)_config_opts += --disable-xtest --disable-xv --disable-xvmc
endef

define $(package)_preprocess_cmds
  find . -type f -name 'Makefile.in' -exec rm {} + && \
  rm -rf build-aux/* && \
  rm ChangeLog INSTALL aclocal.m4 configure m4/libtool.m4 m4/ltoptions.m4 m4/ltsugar.m4 m4/ltversion.m4 m4/lt~obsolete.m4 src/config.h.in && \
  autoreconf -fi && \
  cp -f $(BASEDIR)/config.guess $(BASEDIR)/config.sub build-aux && \
  patch -p1 -i $($(package)_patch_dir)/remove_pthread_stubs.patch
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

define $(package)_postprocess_cmds
  rm -rf share lib/*.la
endef