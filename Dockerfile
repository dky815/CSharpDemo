# Build image (Linux)
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build
RUN apk --no-cache add git
RUN git clone https://github.com/dky815/CSharpDemo.git
WORKDIR /CSharpDemo
RUN dotnet restore
RUN dotnet publish --no-restore --configuration Release

# Runtime image (Linux)
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
WORKDIR /app
COPY --from=build /CSharpDemo/bin/Release/net6.0/publish/ .

EXPOSE 5000

ENV ASPNETCORE_URLS http://*:5000
ENV ASPNETCORE_ENVIRONMENT Production
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true

ENTRYPOINT dotnet dotnet-demoapp.dll