FROM mcr.microsoft.com/dotnet/aspnet:6.0.5-bullseye-slim-amd64 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0.300-bullseye-slim-amd64 AS build
WORKDIR /src
COPY nuget.config .
COPY api/packages.lock.json .
COPY api/api.csproj .
RUN dotnet restore -v d --locked-mode api.csproj
COPY api/ .
WORKDIR /src
RUN dotnet build api.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish api.csproj -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "api.dll"]
