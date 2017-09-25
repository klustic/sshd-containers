.PHONY: all image
all: lab01 ir_lab_image
ir_lab_image: docker/Dockerfile
	docker build -t $@  -f $^ .
lab01:
	$(MAKE) -C src
