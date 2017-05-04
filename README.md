# Content Package Transcoder

## Running locally
You can run the transcoder locally using Cargo with:

mvn clean verify org.codehaus.cargo:cargo-maven2-plugin:run

The application will be at localhost:8080/transcoder

Packages will be saved in target/transcoder/WEB-INF/upload-repository
