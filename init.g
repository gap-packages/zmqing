#
# zmqing: ZMQ bindings for GAP
#
# Reading the declaration part of the package.
#
_PATH_SO:=Filename(DirectoriesPackagePrograms("zmqing"), "zmqing.so");
if _PATH_SO <> fail then
    LoadDynamicModule(_PATH_SO);
fi;
Unbind(_PATH_SO);

ReadPackage( "zmqing", "gap/zmqing.gd");
