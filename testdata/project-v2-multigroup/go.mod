module sigs.k8s.io/kubebuilder/testdata/project-v2-multigroup

go 1.13

require (
	github.com/go-logr/logr v0.1.0
	github.com/onsi/ginkgo v1.12.1
	github.com/onsi/gomega v1.10.1
	golang.org/x/sys v0.0.0-20220330033206-e17cdc41300f // indirect; we enforce this version to supports go 1.18+
	k8s.io/api v0.18.6
	k8s.io/apimachinery v0.18.6
	k8s.io/client-go v0.18.6
	sigs.k8s.io/controller-runtime v0.6.4
)
