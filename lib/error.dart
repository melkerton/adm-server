class ErrorEndpointDirectoryNotFound extends Error {}

class ErrorSourcesEndpointFileNotFound extends Error {}

class ErrorResponseFilePathNotFound extends Error {}

class ErrorResponseWriterEmptyHttpMessage extends Error {}

class ErrorEndpointIndexFileIsEmpty extends Error {}

class ErrorEndpointExpectedYamlList extends Error {}

class ErrorEndpointExpectedYamlMap extends Error {}

class ErrorEndpointResponseIsUndefined extends Error {}

class ErrorEndpointResponseFileNotFound extends Error {}

class ErrorSourcesDirNotFound extends RecoverableError {}

// validated (none)

class FatalError extends Error {}

class RecoverableError extends Error {}
