# Writes /build.
FROM docker4gis/angular-builder:v0.0.20 AS builder

# Serves /wwwroot.
FROM docker4gis/angular:v0.0.20

COPY --from=builder /build /wwwroot
