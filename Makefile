# Define variables
BUILDER_NAME = devcontainer-builder
IMAGE_TAG_BASE = gitlab.personal.bryanph.com:5050/bryanph/devcontainer
BASE_IMAGES = debian:bookworm # ubuntu:noble
PLATFORMS = linux/amd64 #linux/arm64

# Create and use the buildx builder
.PHONY: buildx_create
buildx_create:
	@docker buildx create --use --name $(BUILDER_NAME) 

# Inspect and bootstrap the buildx builder
.PHONY: buildx_inspect
buildx_inspect:
	@docker buildx inspect --bootstrap

# Build and push the images for each base image and platform
.PHONY: buildx_build
buildx_build: buildx_create buildx_inspect
	for base_image in $(BASE_IMAGES); do \
	  for platform in $(PLATFORMS); do \
	    base_image_name=$$(echo $$base_image | cut -d: -f1); \
	    platform_name=$$(echo $$platform | tr '/' '-'); \
	    image_tag=$(IMAGE_TAG_BASE):$$base_image_name-$$platform_name; \
	    echo "Building $$image_tag..."; \
	    cd .devcontainer/ && \
	    docker buildx build --platform $$platform \
	      --output "type=image,push=true" \
	      --tag $$image_tag \
		  --tag $(IMAGE_TAG_BASE):$$base_image_name \
		  --tag $(IMAGE_TAG_BASE):$$base_image_name-latest \
		  --tag $(IMAGE_TAG_BASE):latest \
	      --builder $(BUILDER_NAME) \
	      -f Containerfile . \
	      --build-arg BASE_IMAGE=$$base_image; \
	  done; \
	done

# Stop the buildx builder
.PHONY: buildx_stop
buildx_stop:
	-@docker buildx stop $(BUILDER_NAME)

# A complete run for convenience
.PHONY: buildx
buildx: buildx_clean buildx_create buildx_inspect buildx_build buildx_stop

# Clean up by removing the builder
.PHONY: buildx_clean
buildx_clean:
	-@docker buildx rm $(BUILDER_NAME)

.PHONY: buildx_bake_print
buildx_bake_print:
	-docker buildx bake --print devcontainer

.PHONY: buildx_bake_push
buildx_bake_push:
	-docker buildx bake --push --progress plain all

.PHONY: buildx_bake_arm
buildx_bake_arm:
	-docker buildx bake --load --progress plain arm64
