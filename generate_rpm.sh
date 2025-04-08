
# NOTE: $ARCH is environment variable
set -e

RPMDEST=$1
RPMBUILD=$2
RPMNAME=$3
VERSION=$4
SUMMARY=$5
DESCRIPTION=$6
LICENSE=$7
TARFILE=$8
shift 8

if [ -d $RPMBUILD ]
then
  rm -r $RPMBUILD
fi
mkdir -p $RPMBUILD/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp $TARFILE $RPMBUILD/SOURCES

cat > $RPMBUILD/SPECS/$RPMNAME.spec << EOF
Name: $RPMNAME
Version: $VERSION
Release: 1
Summary: $SUMMARY
ExclusiveArch: $ARCH
License: $LICENSE
Source0: $TARFILE

%description
$DESCRIPTION

%prep
%setup -q
%install
rm -rf %{buildroot}
mkdir -p %{buildroot}
EOF

FILES=()
while [ $# -ne 0 ]
do
  SRC=$1
  DST=$2
  shift 2

  DSTDIR=$(dirname $DST)

  echo "mkdir -p %{buildroot}/$DSTDIR" >> $RPMBUILD/SPECS/$RPMNAME.spec
  echo "cp -P $SRC %{buildroot}/$DST" >> $RPMBUILD/SPECS/$RPMNAME.spec
  FILES+=($DST)
done

echo "%files" >> $RPMBUILD/SPECS/$RPMNAME.spec
for f in ${FILES[@]}
do
  echo "$f" >> $RPMBUILD/SPECS/$RPMNAME.spec
done

rpmbuild --define "_topdir $RPMBUILD" --define "_libdir %{_prefix}/lib" -ba $RPMBUILD/SPECS/$RPMNAME.spec
cp $RPMBUILD/RPMS/$ARCH/$RPMNAME-$VERSION-1.$ARCH.rpm $RPMDEST
