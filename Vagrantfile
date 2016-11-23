# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end
  $script = <<BOOTSTRAP
sudo apt-get update -qq
sudo apt-get install -y git
sudo apt-get install -y binutils-mingw-w64-x86-64 gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 gfortran-mingw-w64-x86-64 mingw-w64 mingw-w64-x86-64-dev mingw-w64-tools
sudo apt-get install -y tree
sudo apt-get autoremove
export DISPLAY=:99.0
/sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16
mkdir -p $HOME/.wine/drive_c/windows
chmod -R 775 $HOME/.wine
rm -f $HOME/.wine/drive_c/windows/libstdc++-6.dll
rm -f $HOME/.wine/drive_c/windows/libgcc_s_sjlj-1.dll
rm -f $HOME/.wine/drive_c/windows/libgfortran-3.dll
rm -f $HOME/.wine/drive_c/windows/libquadmath-0.dll
ln -sfn /usr/lib/gcc/x86_64-w64-mingw32/4.8/libstdc++-6.dll     $HOME/.wine/drive_c/windows/
ln -sfn /usr/lib/gcc/x86_64-w64-mingw32/4.8/libgcc_s_sjlj-1.dll $HOME/.wine/drive_c/windows/
ln -sfn /usr/lib/gcc/x86_64-w64-mingw32/4.8/libgfortran-3.dll   $HOME/.wine/drive_c/windows/
ln -sfn /usr/lib/gcc/x86_64-w64-mingw32/4.8/libquadmath-0.dll   $HOME/.wine/drive_c/windows/
ln -sfn /usr/x86_64-w64-mingw32/lib/libwinpthread-1.dll         $HOME/.wine/drive_c/windows/
git clone https://github.com/mhsieh/mingw-w64-htslib
cd mingw-w64-htslib/
curl -O -L http://zlib.net/zlib-1.2.8.tar.gz
tar zxvf zlib-1.2.8.tar.gz
git clone https://github.com/PacificBiosciences/htslib.git
patch -p0 < htslib.patch
make x64
echo $?
rsync -avx --delete x64/ /vagrant/x64/
BOOTSTRAP

  config.vm.provision :shell, :inline => $script
end
