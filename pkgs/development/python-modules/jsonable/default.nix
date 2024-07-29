{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  fetchpatch2,
}:

buildPythonPackage rec {
  pname = "jsonable";
  version = "0.3.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "halfak";
    repo = "python-jsonable";
    rev = "refs/tags/${version}";
    hash = "sha256-3FIzG2djSZOPDdoYeKqs3obQjgHrFtyp0sdBwZakkHA=";
  };

  patches = [
    # https://github.com/halfak/python-jsonable/pull/2
    (fetchpatch2 {
      name = "eq-to-assert.patch";
      url = "https://github.com/halfak/python-jsonable/pull/2/commits/335e61bb4926e644aef983f7313793bf506d2463.patch";
      hash = "sha256-tCVA0wG+UMyB6oaNf4nbZ2BPWkNumaGPcjP5VJKegBo=";
    })
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "jsonable" ];

  meta = with lib; {
    description = "Provides an abstract base class and utilities for defining trivially JSONable python objects";
    homepage = "https://github.com/halfak/python-jsonable";
    license = licenses.mit;
    maintainers = with maintainers; [ GaetanLepage ];
  };
}
