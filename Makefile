# vim: set ts=2 sw=2 noet:

PROJECT=semanticscuttle

build:
	docker build -t glenux/$(PROJECT) .

prepare:
	docker run -d --name $(PROJECT)_lampbox glenux/lampbox || \
        docker start $(PROEJCT)_lampbox || \
        true

run: clean prepare
	docker run --rm \
        --name $(PROJECT)_app \
        --link $(PROJECT)_lampbox:db \
        -p 8000:8000 \
        -i -t glenux/$(PROJECT)
	#-v $$(pwd):/poieticgen \

test: clean prepare
	docker run --rm \
        --name $(PROJECT)_app \
        --link $(PROJECT)_lampbox:db \
        -p 8000:8000 \
        -i -t glenux/$(PROJECT) /bin/bash
	#-v $$(pwd):/poieticgen

clean:
	docker rm -f $(PROJECT)_app || true

distclean:
	docker rm -f $(PROJECT)_lampbox || true

