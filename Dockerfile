#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim as base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["src/Blazor.Wasm", "src/Blazor.Wasm"]
#COPY ["src/Blazor.Wasm/Server/Blazor.Wasm.Server.csproj", "src/Blazor.Wasm/Server/"]
#COPY ["src/Blazor.Wasm/Client/Blazor.Wasm.Client.csproj", "src/Blazor.Wasm/Client/"]
#COPY ["src/Blazor.Wasm/Shared/Blazor.Wasm.Shared.csproj", "src/Blazor.Wasm/Shared/"]
RUN dotnet restore "src/Blazor.Wasm/Server/Blazor.Wasm.Server.csproj"
COPY . .
WORKDIR "/src/src/Blazor.Wasm/Server"
RUN dotnet build "Blazor.Wasm.Server.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Blazor.Wasm.Server.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "Blazor.Wasm.Server.dll","--server.urls","http://*:8080"]
