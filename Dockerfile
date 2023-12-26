FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App
COPY . ./
RUN dotnet restore
RUN dotnet build
RUN dotnet publish -c Release -o out


# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000
ENV ASPNETCORE_ENVIRONMENT=”development”
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "appservice-test.dll"]
