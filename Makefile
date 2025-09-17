
# For demo purposes I'll dogfood some SBOMs that I know about
REFS=\
 registry.redhat.io/rhtas/ec-rhel9:0.7 \
 registry.redhat.io/rhtas/ec-rhel9:0.6 \
 registry.redhat.io/rhtas/ec-rhel9:0.5

.PHONY=fetch-sboms
fetch-sboms:
	@for ref in $(REFS); do\
	  bin/fetch-sbom.sh $$ref; \
	done

check-sboms:
	@for sbom in sboms/*.json; do\
	  bin/check-sbom.sh $$sbom; \
	done
