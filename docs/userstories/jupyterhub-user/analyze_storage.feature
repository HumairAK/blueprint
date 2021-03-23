Feature: As a user of JupyterHub I want to know how much local storage (PVC) I have

    Background:
        Given I am a user of MOC-ZERO
        * I have access to JupyteHub on MOC-ZERO

    Scenario: Assess storage via Grafana dashboard

        When I visit https://grafana-route-opf-monitoring.apps.zero.massopen.cloud/d/YuYfkHYMk/jupyterhub-usage?orgId=1
        * I select "User ID" and pick my OCP user name

         Then the amount of free storage in my pvc can be assessed by inspecting the used/total space panel.

    Scenario: Assess storage via Jupyterhub

        When I visit https://jupyterhub-opf-jupyterhub.apps.zero.massopen.cloud
        * I login using Openshift MOC-SSO login
        * I spawn a notebook image with: name s2i-minimal-notebook:v0.0.7, container size small, gpu count 0
        * I wait for notebook server to start
        * I click "new" and click "terminal"
        * I type `df -h` in the new terminal

        Then the amount of free storage in my pvc should be listed under "Available" column, mounted on /opt/app-root/src
