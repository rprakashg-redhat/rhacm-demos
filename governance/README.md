# Governance
This section demonstrates pushing Governance policies to Advanced Cluster Management Hub cluster with OpenShift Gitops and Kustomize RHACM Policy generator plugin. This is useful to drive best practices configuration across all clusters in your entire kubernetes domain through RedHat Advanced Cluster management

## Pre-Requisites
* Ansible 
* OpenShift cluster
* Login to OpenShift cluster and copy the token into an environment variable as show below
```
export TOKEN={replace with login token}
```

## Steps to see this in action
Follow steps below to see this in action.

* Install and Configure ACM by running the command below
```
ansible-playbook install/install-configure-acm-playbook.yaml --extra-vars=token=${TOKEN}
```
The Ansible playbook will install ACM operator, create a hub cluster and also installs OpenShift gitops operator

* We are going to use an Init container to copy the Kustomize Policy generator plugin from RHACM application subscription container image to OpenShift GitOps container that runs kustomize. Additionally, OpenShift GitOps must be configured to provide the --enable-alpha-plugins flag when you run Kustomize. Run the following command to configure OpenShift GitOps as shown below
```
oc -n openshift-gitops patch argocd openshift-gitops --type merge --patch "$(curl https://raw.githubusercontent.com/rprakashg-redhat/rhacm-demos/main/governance/openshift-gitops/argocd-patch.yaml)"
```

* Next we need to grant OpenShift Gitops access to create policies on the RHACM hub cluster. We are going to do that by creating a ClusterRole and ClusterRoleBinding to assign appropriate permissions to Service Account used by OpenShift GitOps. Run the command below
```
oc apply -f https://raw.githubusercontent.com/rprakashg-redhat/rhacm-demos/main/governance/openshift-gitops/cluster-role.yaml
```

* Lastly we will create the ArgoCD application that will generate the policies on RHACM hub cluster using OpenShift GitOps. Run the command below
```
oc apply -f https://raw.githubusercontent.com/rprakashg-redhat/rhacm-demos/main/governance/openshift-gitops/app.yaml
```

Login to the ArgoCD console to view the status of the application. Additionally you can examine the topology view in RHACM hub cluster

Hope this helps. If any questions reach out to me here or through my [blog](https://rprakashg.github.io)

