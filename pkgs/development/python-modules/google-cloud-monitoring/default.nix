{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, google-cloud-testutils
, libcst
, proto-plus
, pandas
, pytestCheckHook
, pytest-asyncio
, mock
, pythonOlder
}:

buildPythonPackage rec {
  pname = "google-cloud-monitoring";
  version = "2.11.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-eLd8lHhyGjJBTaNzP8amzWa3LyaAixzj+6EpRU2J0bg=";
  };

  propagatedBuildInputs = [
    libcst
    google-api-core
    proto-plus
  ];

  checkInputs = [
    google-cloud-testutils
    mock
    pandas
    pytestCheckHook
    pytest-asyncio
  ];

  disabledTests = [
    # requires credentials
    "test_list_monitored_resource_descriptors"
  ];

  pythonImportsCheck = [
    "google.cloud.monitoring"
    "google.cloud.monitoring_v3"
  ];

  meta = with lib; {
    description = "Stackdriver Monitoring API client library";
    homepage = "https://github.com/googleapis/python-monitoring";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
