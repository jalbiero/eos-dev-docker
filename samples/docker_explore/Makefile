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

SAMPLE_NAME = explore

DOCKER_VERSION = latest
DOCKER_CONTAINER = ${SAMPLE_NAME}-sample
DOCKER_COMMON = --name ${DOCKER_CONTAINER} jalbiero/eosdev:${DOCKER_VERSION}
DOCKER_RUN = docker run -it ${DOCKER_COMMON}

explore_bash: docker-stop
	 ${DOCKER_RUN} bash

explore_mc: docker-stop
	 ${DOCKER_RUN} mc

docker-stop:
	@-docker rm -f ${DOCKER_CONTAINER}
