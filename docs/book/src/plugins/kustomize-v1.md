# Kustomize (kustomize/v1)

The kustomize plugin allows you to scaffold all kustomize manifests used to work with the language plugins such as `go/v2` and `go/v3`. 
By using the kustomize plugin, you can create your own language plugins and ensure that you will have the same configurations 
and features provided by it. 

Note that projects such as [Operator-sdk][sdk] consume the Kubebuilder project as a lib and provide options to work with other languages
like Ansible and Helm. The kustomize plugin allows them to easily keep a maintained configuration and ensure that all languages have
the same configuration. It is also helpful if you are looking to provide nice plugins which will perform changes on top of
what is scaffolded by default. With this approach we do not need to keep manually updating this configuration in all possible language plugins
which uses the same and we are also
able to create "helper" plugins which can work with many projects and languages.

<aside class="note">
<h1>Examples</h1>

You can check the kustomize content by looking at the `config/` directory. Samples are provided under the [testdata][testdata]
directory of the Kubebuilder project.

</aside> 


## When to use it ?

If you are looking to scaffold the kustomize configuration manifests for your own language plugin 

## How to use it ?

If you are looking to define that your language plugin should use kustomize use the [Bundle Plugin][bundle]
to specify that your language plugin is a composition with your plugin responsable for scaffold
all that is laguage specific and kustomize for its configuration, see: 

```go
	// Bundle plugin which built the golang projects scaffold by Kubebuilder go/v3
	// The follow code is creating a new plugin with its name and version via composition
	// You can define that one plugin is composite by 1 or Many others plugins
	gov3Bundle, _ := plugin.NewBundle(golang.DefaultNameQualifier, plugin.Version{Number: 3},
		kustomizecommonv1.Plugin{}, // scaffold the config/ directory and all kustomize files
		golangv3.Plugin{}, // Scaffold the Golang files and all that specific for the language e.g. go.mod, apis, controllers
	)
```

Also, with Kubebuilder, you can use kustomize alone via:

```sh
kubebuilder init --plugins=kustomize/v1 
$ ls -la 
total 24
drwxr-xr-x   6 camilamacedo86  staff  192 31 Mar 09:56 .
drwxr-xr-x  11 camilamacedo86  staff  352 29 Mar 21:23 ..
-rw-------   1 camilamacedo86  staff  129 26 Mar 12:01 .dockerignore
-rw-------   1 camilamacedo86  staff  367 26 Mar 12:01 .gitignore
-rw-------   1 camilamacedo86  staff   94 31 Mar 09:56 PROJECT
drwx------   6 camilamacedo86  staff  192 31 Mar 09:56 config
```

Or combined with the base language plugins:

```sh
# Provides the same scaffold of go/v3 plugin which is a composition (kubebuilder init --plugins=go/v3)
kubebuilder init --plugins=kustomize/v1,base.go.kubebuilder.io/v3 --domain example.org --repo example.org/guestbook-operator 
```

## Subcommands

The kustomize plugin implements the following subcommands:

* init (`$ kubebuilder init [OPTIONS]`)
* create api (`$ kubebuilder create api [OPTIONS]`)
* create webhook (`$ kubebuilder create api [OPTIONS]`)

<aside class="note">
<h1>Create API and Webhook</h1>

Its implementation for the subcommand create api will scaffold the kustomize manifests
which are specific for each API, see [here][kustomize-create-api]. The same applies
to its implementation for create webhook.

</aside> 

## Affected files

The following scaffolds will be created or updated by this plugin:

* `config/*`

## Further resources

* Check the kustomize [plugin implementation](https://github.com/kubernetes-sigs/kubebuilder/tree/master/pkg/plugins/common/kustomize) 
* Check the [kustomize documentation][kustomize-docs]
* Check the [kustomize repository][kustomize-github]

[sdk]:https://github.com/operator-framework/operator-sdk
[testdata]: https://github.com/kubernetes-sigs/kubebuilder/tree/master/testdata/
[bundle]: https://github.com/kubernetes-sigs/kubebuilder/blob/master/pkg/plugin/bundle.go
[kustomize-create-api]: https://github.com/kubernetes-sigs/kubebuilder/blob/master/pkg/plugins/common/kustomize/v1/scaffolds/api.go#L72-L84
[kustomize-docs]: https://kustomize.io/
[kustomize-github]: https://github.com/kubernetes-sigs/kustomize