# Spring Boot Sample Applications

This repository contains very simple and hence basic Spring Boot sample applications that expose actuator endpoints.
The main purpose of this repository is to deploy different versions of Spring Boot apps to a k8s cluster to check compatibility with different Spring Boot Admin versions.

## Usage
 1. Compile and create docker images by running `mvn package`
 1. Deploy docker images to k8s by using provided helm chart or running `runHelm.sh --install` 