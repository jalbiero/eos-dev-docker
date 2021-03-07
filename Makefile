# Copyright (c) 2020/2021, jalbiero, all rights reserved.
#
# The MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

DKR_VERSION = 1.1.0
EOS_VERSION = 2.0.10
CDT_VERSION = 1.7.0

FULL_VERSION = v$(EOS_VERSION)-$(CDT_VERSION)-$(DKR_VERSION)

#EOS_FILE = eosio_$(EOS_VERSION)-1-ubuntu-18.04_amd64.deb
CDT_FILE = eosio.cdt_$(CDT_VERSION)-1-ubuntu-18.04_amd64.deb

DEPS_DIR=./tmp

.PHONY: build-image push-image


make_deps_dir:
	@mkdir -p $(DEPS_DIR)


# This target has some optimization code because cloning/initing is
# really slow.
# Use "make build-image FETCH_ALL=1" in order to update (fetch tags, 
# branches, etc) the current cloned source. Be aware that this update
# will regenerate the EOS installation layer inside the docker even 
# if you did not change the blockchain version (EOS_VERSION)
get_eos_source: make_deps_dir
	if [ ! -d $(DEPS_DIR)/eos ]; then \
        cd $(DEPS_DIR) && \
        git clone -b v$(EOS_VERSION) https://github.com/EOSIO/eos.git --recursive && \
        cd eos; \
    fi
ifdef FETCH_ALL
	if [ -d $(DEPS_DIR)/eos ]; then \
        cd $(DEPS_DIR)/eos && \
        git fetch --all --tags && \
        git checkout v$(EOS_VERSION); \
    fi
endif
	git submodule update --init --recursive


get_cdt_package: make_deps_dir
	if [ ! -f $(DEPS_DIR)/$(CDT_FILE) ]; then \
        cd $(DEPS_DIR) && \
        wget https://github.com/eosio/eosio.cdt/releases/download/v$(CDT_VERSION)/$(CDT_FILE); \
    fi


build-image: get_eos_source get_cdt_package
	docker build \
        --build-arg deps_dir=$(DEPS_DIR) \
        --build-arg cdt_file=$(CDT_FILE) \
        -t jalbiero/eosdev .


push-image: test-image
	docker tag jalbiero/eosdev jalbiero/eosdev:$(FULL_VERSION)
	docker push jalbiero/eosdev:$(FULL_VERSION)
	docker tag jalbiero/eosdev jalbiero/eosdev:latest
	docker push jalbiero/eosdev:latest


test-image:
	@echo TODO
