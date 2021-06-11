
#
#   Install dependencies
# $ conan install .
#
#   Conan build dependencies
# $ conan install . --build
#
#   Conan build
# $ conan build .
#
#   Build from cmake
# $ cmake --build ./bld -j 8
#
#   install / build / package
# $ ./clean.sh && conan install . && conan build . && conan package .
#
#   Install / Uninstall
# $ sudo cmake --install ./bld && sudo ./run.sh uninstall
#

import datetime
from conans import ConanFile, tools, CMake

# Read from config file
def readConfig(fname):
    cfg = {}
    with open(fname) as f:
        lines = f.readlines()
        for line in lines:
            parts = line.strip().replace("\t", " ").split(" ")
            k = parts.pop(0).strip()
            cfg[k] = " ".join(parts).strip()
    return cfg


class Library_libblank(ConanFile):

    # Read config file
    cfg = readConfig('PROJECT.txt')
    for k in ['name', 'version', 'description', 'url', 'license', 'company', 'author']:
        if k not in cfg:
            raise Exception("Variable '%s' not specified in 'PROJECT.txt'" % k)
        locals()[k] = cfg[k]

    # Create a build number
    buildno = datetime.datetime.now().strftime("%y.%m.%d.%H%M")

    # requires = []
    settings = "os", "compiler", "arch", "build_type"
    options = {}
    default_options = ""
    exports = "*"
    generators = "cmake"
    build_policy = "missing"
    build_output = "./bld"
    install_path = "/usr/local"

    def conan_info(self):
        self.info.settings.clear()

    def configure(self):
        pass

    def build(self):
        cmake = CMake(self)
        print("cmake.command_line : %s" % cmake.command_line)
        print("cmake.build_config : %s" % cmake.build_config)
        appopts = "-DAPPBUILD=\"%s\" -DCMAKE_INSTALL_PREFIX=\"%s\"" % (self.buildno, self.install_path)
        self.run('cmake . -B %s %s %s' % (self.build_output, cmake.command_line, appopts))
        self.run("cmake --build %s -j 8 %s" % (self.build_output, cmake.build_config))

    def package(self):
        self.run('cpack -B ./pck -G DEB -C Release --config %s/CPackConfig.cmake' % self.build_output)
        #self.copy("*.so")

    def package_info(self):
        print(self.package_folder)

