chrootable_systemctl_enable() {
  if [ -n "${OMARCHY_CHROOT_INSTALL:-}" ]; then
    sudo systemctl enable $1
  else
    sudo systemctl enable --now $1
  fi
}
