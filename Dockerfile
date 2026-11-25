FROM linuxserver/webtop:ubuntu-kde-2cb25acc-ls193

# MAX_RES capped the Xvfb screen on older X11 bases; this Wayland base ignores it.
# 15-small-plan-resolution locks the desktop at 1920x1080 instead: under 1600 MiB, since a 4K
# window ran KDE out of memory on the 1 GB Trial plan.
ENV MAX_RES=3840x2160 RESOLUTION_LOCK_BELOW_MIB=1600

# ponytail: one custom-init script adds an unauthenticated /healthcheck
# location for Railway's healthcheck prober; everything else is stock.
COPY root/ /
RUN chmod +x /railway-gate.sh /custom-cont-init.d/15-small-plan-resolution /custom-cont-init.d/20-healthcheck /custom-services.d/drop-file-cache /usr/local/bin/drop-file-cache

# Free plan (0.5 GB): serve a "needs 1 GB" page instead of starting the desktop (see railway-gate.sh).
ENTRYPOINT ["/railway-gate.sh"]
