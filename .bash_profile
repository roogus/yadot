# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
USR_NAME="$(whoami)"
BASHRC="/home/${USR_NAME}/.bashrc"

if [[ -f "${BASHRC}" ]] ; then
	. "${BASHRC}"
fi
