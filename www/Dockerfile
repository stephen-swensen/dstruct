﻿FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY nuget.config .
COPY www/www.csproj .
RUN dotnet restore www.csproj
COPY www/ .
WORKDIR /src
RUN dotnet build www.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish www.csproj -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "www.dll"]
