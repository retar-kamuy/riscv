#!/usr/bin/bash

CMDNAME=`basename $0`

while getopts brecv-: opt; do
	# OPTIND 番目の引数を optarg へ代入
	optarg="${!OPTIND}"
	[[ "$opt" = - ]] && opt="-$OPTARG"

	case "-$opt" in
		-b|--build)
			podman build --rm -t rockylinux .
			;;
		-r|--run)
			podman run -it -detach \
				--name rockylinux \
				--publish 8080:8080 --publish 50000:50000 \
				--publish 3001:3001 \
				localhost/rockylinux
				shift
				;;
		-e|--exec)
			podman exec -it rockylinux /bin/bash
			shift
			;;
		-c|--commit)
			FLG_COMMIT="TRUE"
			shift
			;;
		-v|--version)
			echo 'v1.0.0'
			exit
			;;
		--)
			break
			;;
		-\?)
			exit 1
			;;
		--*)
			echo "$0: illegal option -- ${opt##-}" >&2
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

if [ "$FLG_COMMIT" = "TRUE" ]; then
	docker stop rockylinux
	docker commit rockylinux localhost/rockylinux
fi

exit 0
