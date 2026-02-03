{ lib,
  stdenv,
  cmake,
  qtbase,
  qtwayland,
  wrapQtAppsHook
}:

stdenv.mkDerivation {
  pname = "selectdefaultapplication-qt6";
  version = "2.1";

  src = ../.;

  nativeBuildInputs = [
    cmake
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase
    qtwayland
  ];

  installPhase = ''
    install -Dm755 sda-qt6 $out/bin/sda-qt6
    install -Dm644 $src/sda-qt6.desktop $out/share/applications/sda-qt6.desktop
    install -Dm644 $src/sda-qt6.png $out/share/icons/hicolor/128x128/apps/sda-qt6.png
  '';

  meta = with lib; {
    description = "A Qt6 application to select default applications";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
