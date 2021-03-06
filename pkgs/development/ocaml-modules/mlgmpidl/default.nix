{ stdenv, fetchFromGitHub, perl, ocaml, findlib, camlidl, gmp, mpfr }:

stdenv.mkDerivation rec {
  name = "ocaml${ocaml.version}-mlgmpidl-${version}";
  version = "1.2.8";
  src = fetchFromGitHub {
    owner = "nberth";
    repo = "mlgmpidl";
    rev = version;
    sha256 = "1csqplyxi5gq6ma7g4la2x20mhz1plmjallsankv0mn0x69zb1id";
  };

  buildInputs = [ perl gmp mpfr ocaml findlib camlidl ];

  prefixKey = "-prefix ";
  configureFlags = [
    "--gmp-prefix ${gmp.dev}"
    "--mpfr-prefix ${mpfr.dev}"
  ];

  postConfigure = ''
    sed -i Makefile \
      -e 's|^	/bin/rm |	rm |'
  '';

  createFindlibDestdir = true;

  meta = {
    description = "OCaml interface to the GMP library";
    homepage = https://www.inrialpes.fr/pop-art/people/bjeannet/mlxxxidl-forge/mlgmpidl/;
    license = stdenv.lib.licenses.lgpl21;
    inherit (ocaml.meta) platforms;
    maintainers = [ stdenv.lib.maintainers.vbgl ];
  };
}
