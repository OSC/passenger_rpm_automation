# DO NOT EDIT!!
#
# This file is automatically generated from internal/lib/distro_info.sh.erb,
# and definitions from internal/lib/docker_image_info.sh.
#
# Edit those and regenerate distro_info.sh by running:
# internal/scripts/regen_distro_info_script.sh


function get_buildbox_image()
{
  echo "ohiosupercomputer/ondemand_passenger_rpm_automation_buildbox:1.0.0"
}

function el_name_to_distro_name()
{
	local EL="$1"
	if [[ "$EL" = el7 ]]; then
		echo centos7
	elif [[ "$EL" = el6 ]]; then
		echo centos6
	else
		echo "ERROR: unknown distribution name." >&2
		return 1
	fi
}

function distro_name_to_testbox_image()
{
	local DISTRIBUTION="$1"
	if [[ "$DISTRIBUTION" = centos7 ]]; then
    echo phusion/passenger_rpm_automation_testbox_centos_7:1.0.0
	elif [[ "$DISTRIBUTION" = centos6 ]]; then
    echo phusion/passenger_rpm_automation_testbox_centos_6:1.0.0
	else
		echo "ERROR: unknown distribution name." >&2
		return 1
	fi
}
