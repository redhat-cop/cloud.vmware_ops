# collection_template
You can build a new repository for an Ansible Collection using this template by following [Creating a repository from a template](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template). This README.md contains recommended headings for your collection README.md, with comments describing what each section should contain. Once you have created your collection repository, delete this paragraph and the title above it from your README.md.

# Foo Collection for Ansible
<!-- Add CI and code coverage badges here. Samples included below. -->
[![CI](https://github.com/ansible-collections/REPONAMEHERE/workflows/CI/badge.svg?event=push)](https://github.com/ansible-collections/REPONAMEHERE/actions) [![Codecov](https://img.shields.io/codecov/c/github/ansible-collections/REPONAMEHERE)](https://codecov.io/gh/ansible-collections/REPONAMEHERE)

<!-- Describe the collection and why a user would want to use it. What does the collection do? -->

## Our mission

<!-- Put your collection project's mission statement in here. -->

## Code of Conduct

We follow the [Ansible Code of Conduct](https://docs.ansible.com/ansible/devel/community/code_of_conduct.html) in all our interactions within this project.

If you encounter abusive behavior, please refer to the [policy violations](https://docs.ansible.com/ansible/devel/community/code_of_conduct.html#policy-violations) section of the Code for information on how to raise a complaint.

## Communication

<!--List available communication channels. In addition to channels specific to your collection, we also recommend to use the following ones.-->

We announce important development changes and releases through Ansible's [The Bullhorn newsletter](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn). If you are a collection developer, be sure you are subscribed.

Join us on:
* The Ansible forum:
    * [News & Announcements](https://forum.ansible.com/c/news/5/none)
    * [Get Help](https://forum.ansible.com/c/help/6/none)
    * [Social Spaces](https://forum.ansible.com/c/chat/4)
* Matrix chat rooms:
    * [#users:ansible.com](https://matrix.to/#/#users:ansible.com): general use questions and support
    * [#community:ansible.com](https://matrix.to/#/#community:ansible.com): community and collection development questions
    * [#social:ansible.com](https://matrix.to/#/#social:ansible.com): to say "Good morning, community!"

We take part in the global [Ansible contributor summit](https://github.com/ansible/community/wiki/Contributor-Summit) virtually or in-person. Track [The Bullhorn newsletter](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn) and join us.

For more information about communication, refer to the [Ansible communication guide](https://docs.ansible.com/ansible/devel/community/communication.html).

## Contributing to this collection

<!--Describe how the community can contribute to your collection. At a minimum, fill up and include the CONTRIBUTING.md file containing how and where users can create issues to report problems or request features for this collection. List contribution requirements, including preferred workflows and necessary testing, so you can benefit from community PRs. If you are following general Ansible contributor guidelines, you can link to - [Ansible Community Guide](https://docs.ansible.com/ansible/devel/community/index.html). List the current maintainers (contributors with write or higher access to the repository). The following can be included:-->

The content of this collection is made by people like you, a community of individuals collaborating on making the world better through developing automation software.

We are actively accepting new contributors and all types of contributions are very welcome.

Don't know how to start? Refer to the [Ansible community guide](https://docs.ansible.com/ansible/devel/community/index.html)!

Want to submit code changes? Take a look at the [Quick-start development guide](https://docs.ansible.com/ansible/devel/community/create_pr_quick_start.html).

We also use the following guidelines:

* [Collection review checklist](https://docs.ansible.com/ansible/devel/community/collection_contributors/collection_reviewing.html)
* [Ansible development guide](https://docs.ansible.com/ansible/devel/dev_guide/index.html)
* [Ansible collection development guide](https://docs.ansible.com/ansible/devel/dev_guide/developing_collections.html#contributing-to-collections)

## Collection maintenance

The current maintainers are listed in the [MAINTAINERS](MAINTAINERS) file. If you have questions or need help, feel free to mention them in the proposals.

To learn how to maintain/become a maintainer of this collection, refer to the [Maintainer guidelines](https://docs.ansible.com/ansible/devel/community/maintainers.html).

It is necessary for maintainers of this collection to be subscribed to:

* The collection itself (the `Watch` button -> `All Activity` in the upper right corner of the repository's homepage).
* The [news-for-maintainers repository](https://github.com/ansible-collections/news-for-maintainers).

They also should be subscribed to Ansible's [The Bullhorn newsletter](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn).

## Governance

<!--Describe how the collection is governed. Here can be the following text:-->

The process of decision making in this collection is based on discussing and finding consensus among participants.

Every voice is important. If you have something on your mind, create an issue or dedicated discussion and let's discuss it!

## Tested with Ansible

<!-- List the versions of Ansible the collection has been tested with. Must match what is in galaxy.yml. -->

## External requirements

<!-- List any external resources the collection depends on, for example minimum versions of an OS, libraries, or utilities. Do not list other Ansible collections here. -->

### Supported connections
<!-- Optional. If your collection supports only specific connection types (such as HTTPAPI, netconf, or others), list them here. -->

## Included content

<!-- Galaxy will eventually list the module docs within the UI, but until that is ready, you may need to either describe your plugins etc here, or point to an external docsite to cover that information. -->

## Using this collection

<!--Include some quick examples that cover the most common use cases for your collection content. It can include the following examples of installation and upgrade (change NAMESPACE.COLLECTION_NAME correspondingly):-->

### Installing the Collection from Ansible Galaxy

Before using this collection, you need to install it with the Ansible Galaxy command-line tool:
```bash
ansible-galaxy collection install NAMESPACE.COLLECTION_NAME
```

You can also include it in a `requirements.yml` file and install it with `ansible-galaxy collection install -r requirements.yml`, using the format:
```yaml
---
collections:
  - name: NAMESPACE.COLLECTION_NAME
```

Note that if you install the collection from Ansible Galaxy, it will not be upgraded automatically when you upgrade the `ansible` package. To upgrade the collection to the latest available version, run the following command:
```bash
ansible-galaxy collection install NAMESPACE.COLLECTION_NAME --upgrade
```

You can also install a specific version of the collection, for example, if you need to downgrade when something is broken in the latest version (please report an issue in this repository). Use the following syntax to install version `0.1.0`:

```bash
ansible-galaxy collection install NAMESPACE.COLLECTION_NAME:==0.1.0
```

See [using Ansible collections](https://docs.ansible.com/ansible/devel/user_guide/collections_using.html) for more details.

## Release notes

See the [changelog](https://github.com/ansible-collections/REPONAMEHERE/tree/main/CHANGELOG.rst).

## Roadmap

<!-- Optional. Include the roadmap for this collection, and the proposed release/versioning strategy so users can anticipate the upgrade/update cycle. -->

## More information

<!-- List out where the user can find additional information, such as working group meeting times, slack/IRC channels, or documentation for the product this collection automates. At a minimum, link to: -->

- [Ansible user guide](https://docs.ansible.com/ansible/devel/user_guide/index.html)
- [Ansible developer guide](https://docs.ansible.com/ansible/devel/dev_guide/index.html)
- [Ansible collections requirements](https://docs.ansible.com/ansible/devel/community/collection_contributors/collection_requirements.html)
- [Ansible community Code of Conduct](https://docs.ansible.com/ansible/devel/community/code_of_conduct.html)
- [The Bullhorn (the Ansible contributor newsletter)](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn)
- [Important announcements for maintainers](https://github.com/ansible-collections/news-for-maintainers)

## Licensing

<!-- Include the appropriate license information here and a pointer to the full licensing details. If the collection contains modules migrated from the ansible/ansible repo, you must use the same license that existed in the ansible/ansible repo. See the GNU license example below. -->

GNU General Public License v3.0 or later.

See [LICENSE](https://www.gnu.org/licenses/gpl-3.0.txt) to see the full text.

```
cloud.vmware_ops
├─ .ansible-lint
├─ .config
│  └─ ansible-lint.yml
├─ .git
│  ├─ COMMIT_EDITMSG
│  ├─ FETCH_HEAD
│  ├─ HEAD
│  ├─ ORIG_HEAD
│  ├─ config
│  ├─ hooks
│  │  └─ pre-commit
│  ├─ index
│  ├─ logs
│  │  ├─ HEAD
│  │  └─ refs
│  │     ├─ heads
│  │     │  ├─ main
│  │     │  └─ provision_vm_test
│  │     └─ remotes
│  │        ├─ bardielle
│  │        │  ├─ main
│  │        │  └─ provision_vm
│  │        ├─ machacekondra
│  │        │  ├─ eebuild
│  │        │  ├─ fix_ci
│  │        │  ├─ main
│  │        │  └─ security
│  │        ├─ origin
│  │        │  ├─ HEAD
│  │        │  └─ main
│  │        └─ smiron
│  │           ├─ main
│  │           ├─ provision_vm
│  │           └─ provision_vm_test
│  ├─ objects
│  │  ├─ 01
│  │  │  └─ e6646329f950d9d2d5e7f9e7b618d4a1852943
│  │  ├─ 03
│  │  │  └─ 959ec73801fb1c234726f80816a899b29b8b5b
│  │  ├─ 06
│  │  │  ├─ 5ace0d1ab3f18a9715f21d9ae74b56748e3782
│  │  │  └─ 8264c4d5cd609279eda7db8e7b8e057aa1f162
│  │  ├─ 09
│  │  │  ├─ 205b22ab8605afa8fdbc457b0607b06fb843df
│  │  │  ├─ 8c638e9a5fdd2b6c0f0dc187876e77eb911ebe
│  │  │  └─ c1e9a0f97b84ed536c4c4378b1632b6f691185
│  │  ├─ 0a
│  │  │  └─ 18be740e5ec2a9566181472dc1654305fd11b6
│  │  ├─ 0e
│  │  │  └─ 83eb5d20cebf37327973edcda20a5ef1de4e77
│  │  ├─ 12
│  │  │  └─ 4509e16fa5c252ecd75a25cd9128559b0fc39c
│  │  ├─ 13
│  │  │  └─ 8eec98d32fcd557b97c13c44c32713cb3e2540
│  │  ├─ 1c
│  │  │  └─ 6c47b5232155a800d4601e614503aaed145a1d
│  │  ├─ 20
│  │  │  ├─ 794dc1d4c690d1e31a80087c221fbebac97491
│  │  │  ├─ b996ced79dc05df5641dd5be83ed22511b5963
│  │  │  └─ f7a24605ae22b73314e1f72c248ed6d66e5bad
│  │  ├─ 21
│  │  │  └─ 0ed7fb02c9e3b947eff1767d5a61de3fb996e9
│  │  ├─ 22
│  │  │  └─ c3d6480be6d727149da580b82f46561fcac02f
│  │  ├─ 23
│  │  │  ├─ 5266cf566c81dd5e50573fdd4d710177f19709
│  │  │  └─ e33e596ed20b272803653cf0d7bead1569e36d
│  │  ├─ 25
│  │  │  └─ 1681e169c0eca83fe8701096ff6a57b89581e5
│  │  ├─ 28
│  │  │  └─ c5af79027957506a4b443280804cbe1dcecd9a
│  │  ├─ 29
│  │  │  └─ fc10b7425cf0ddbad7cbc50cd50d86fc518895
│  │  ├─ 2b
│  │  │  └─ 9c79ef3d7c619f60e1b9015e01a0c1aabc7fd9
│  │  ├─ 2f
│  │  │  ├─ d9f9570028dac87fd50b6dd37124d915c8b441
│  │  │  └─ fd7d54f7fdf377a7d0fc1d48ee7402ef72109d
│  │  ├─ 30
│  │  │  ├─ b6d39966744c52478b8903bb7ae727747c5cc8
│  │  │  └─ b925b4f39448a00bd787bd1e48a5c766825152
│  │  ├─ 32
│  │  │  └─ df4df68a621d0e7cd0d244a03e689fe872bd00
│  │  ├─ 33
│  │  │  ├─ 96699bd17b952d300532311a7d248687cbb7a7
│  │  │  ├─ eeca6bdb7fb103f313f645c003471814e16214
│  │  │  └─ f7a5676aaf207966baab64379f9666891416f2
│  │  ├─ 36
│  │  │  ├─ 36d09c27de8705cb9cf339aab928d905a59c00
│  │  │  └─ 8f4b08338b91b21e697d8fe9b8d5d8471c3b71
│  │  ├─ 39
│  │  │  └─ 7cf42133373b9c27bff1bf3cc7ebef5d816251
│  │  ├─ 3a
│  │  │  ├─ a0603f0a98a545955d1245cc0ab39e6cb899be
│  │  │  └─ a9a681caef46e36d27de50c8802bbd2b80e178
│  │  ├─ 3d
│  │  │  └─ 358966faa0fedf620b952b9a46b83f270948c4
│  │  ├─ 3e
│  │  │  └─ d1cc9173ca0a5e3b2541847917e2ef1df3c7c6
│  │  ├─ 3f
│  │  │  ├─ 4ac53e9a78820d02630fdf48730968099d8dc3
│  │  │  ├─ 890267cf3f03093026ab4b5a0aa1e410f1a81b
│  │  │  └─ 96d3233902e033826af6c1df2fc19e3011aa3f
│  │  ├─ 40
│  │  │  ├─ 318d3b1088ece4a95478c25aed50eae8384dad
│  │  │  └─ 3cc8d8bee4e0162328038ed17823603281f5f6
│  │  ├─ 41
│  │  │  └─ 747416fd1dacab9d4d60ce636658c7f29d2293
│  │  ├─ 43
│  │  │  └─ 3ffdcc7ff2f599641147af4aaecf71870396a1
│  │  ├─ 44
│  │  │  └─ 101cd7a5703e47c42c6973c3d2784fcee25dd5
│  │  ├─ 45
│  │  │  ├─ 3434770cfa7a2f9117d5750f4a033177216746
│  │  │  ├─ a3ab9cf500c2c854f032cdc7d4b2f7ddc9ce11
│  │  │  └─ f0d57d7752065138c0c613adf0980ad6a5e30e
│  │  ├─ 47
│  │  │  └─ be9ce200bbff0658ee4a286ba2c95856bd1c6e
│  │  ├─ 4a
│  │  │  └─ 4b917dfee366dfdf95f686ee7271a51313372d
│  │  ├─ 4e
│  │  │  └─ cde522680dad5d762efa885f919d92db466bec
│  │  ├─ 4f
│  │  │  └─ acdf9d43e7f162a5c8e8bce24cd67c3b33daa8
│  │  ├─ 51
│  │  │  └─ 567bdafafe313ad4bf8b691435f88dfe01f2da
│  │  ├─ 52
│  │  │  ├─ 1b345853a7f84771ef2366633a2488541bb9a7
│  │  │  └─ b1ed72e8afad20f80b0926613e8264f966374f
│  │  ├─ 54
│  │  │  └─ 19f8f3abb19460acfbee769512e9617183aed1
│  │  ├─ 55
│  │  │  └─ d8ba9cfa726ee7f7a683c4e391b8194fbba9c0
│  │  ├─ 56
│  │  │  ├─ 712697c1583e22002b56e79e821ec2799d8e60
│  │  │  └─ d7538363846242e9951f8db1b943bfda498c05
│  │  ├─ 57
│  │  │  └─ 2ad4be45d8da21eadd5a2cc48fc32d26ce481a
│  │  ├─ 5d
│  │  │  ├─ 8dc8a00b87641e9b029f809ddfafa6f1aa5c1c
│  │  │  └─ df326dba59616ac1f952f33071b7eae98220e2
│  │  ├─ 5e
│  │  │  └─ a99260776dae620e335675316607677cdbdc46
│  │  ├─ 60
│  │  │  └─ cb6629c01b3159a2a8c3aed2b4c3ddefc84ec5
│  │  ├─ 61
│  │  │  └─ 65baccafeacfbd9dc4a1bcb7d170ed52ab2664
│  │  ├─ 62
│  │  │  ├─ 24f043ab6d7740e67a2711d977e0085737a5c7
│  │  │  └─ 556c47484f829c1bf5ce2b7d501f586a0fc4b8
│  │  ├─ 63
│  │  │  └─ 6571d763789495ee81dc87257b297ab4c9dde1
│  │  ├─ 64
│  │  │  └─ f9300cce2e91458f242af0fb7ad4e9bd287265
│  │  ├─ 65
│  │  │  └─ c6b4b12e27ee24d6c967a3713c3cc8f19a2a0c
│  │  ├─ 66
│  │  │  └─ a52eac169e4b1d63ecce936d1947ab14150567
│  │  ├─ 68
│  │  │  └─ 845c3639227fd90eb20bdcf8433e32c93f5d55
│  │  ├─ 69
│  │  │  └─ 481b4ae972119dcc72bcc16838f3da9844e592
│  │  ├─ 6b
│  │  │  └─ 7a19bb06fada4d153651bb473d92573c6c6a5c
│  │  ├─ 6c
│  │  │  └─ b6efe48d1c7569ab0fc3cafe090e7e93e4f101
│  │  ├─ 6e
│  │  │  └─ f856934115f3596f42e94814c3c72bb86a0f6e
│  │  ├─ 6f
│  │  │  └─ 0164dd7b7848fc0bd17b9538c38eda6b29b9e7
│  │  ├─ 73
│  │  │  └─ 81fc496ba1a97ef6003e929197812253ff9b59
│  │  ├─ 74
│  │  │  └─ 1758c0c5e8934023debe4785260c675ab26785
│  │  ├─ 75
│  │  │  ├─ 77a1cf1186163f2945d10194ed3a852d14c820
│  │  │  └─ e3c055248bcd908dfc2c5e6b0e399518ca9347
│  │  ├─ 77
│  │  │  ├─ 3257fbb3030474886b3eaf586d05f148848450
│  │  │  └─ c28b344f34aa759a651a05431920ef7ab629f7
│  │  ├─ 79
│  │  │  └─ 5c1a06a6cd6526ec56e2287e2591811e20c5b8
│  │  ├─ 7a
│  │  │  └─ c3c99df32fb708d27f0245a2494aa0d03f57cd
│  │  ├─ 7d
│  │  │  └─ 793eb05feb42b1e93c71fd7f2a4c88fe2eb41f
│  │  ├─ 80
│  │  │  ├─ 62f8dd3231a51d2f5fd71b273d7c6447c4bd2f
│  │  │  └─ c052841d589e4e9872d2548040b8fc7791face
│  │  ├─ 81
│  │  │  ├─ 4fd10390fcd901d10d222a96fe7512074ceb41
│  │  │  ├─ c08d0d5730be4e0c99379ac8eb172106d8534e
│  │  │  └─ fccfb13094816c577be1b228e0367ebd578af1
│  │  ├─ 83
│  │  │  └─ b1af224d3ecd80bc0dff206c54d98aa4dd582f
│  │  ├─ 87
│  │  │  └─ 629e6137cf9e3ebf49ee2083287c596d3301b1
│  │  ├─ 88
│  │  │  └─ 49ae8023648d56cced63bd638c14b3655e5e8d
│  │  ├─ 8a
│  │  │  └─ a28164923514f493c0024ae2fe1eff48716b9f
│  │  ├─ 8e
│  │  │  └─ ccb00327e27e5014c78316e5c0310eaf677d01
│  │  ├─ 8f
│  │  │  └─ 47f17a263972b6fffb81b2887efb16ebe06dd2
│  │  ├─ 91
│  │  │  └─ 9f0e159b5f7eb7a8182258f90b20f7e9670d5d
│  │  ├─ 92
│  │  │  ├─ 93a16b66aac13829c53e8ef70eac7ad03ae83d
│  │  │  └─ be62f59a7046b7bc59c3c3aa3ec7609bf3822e
│  │  ├─ 94
│  │  │  └─ 679105e3c42187599f7c7c998ee4003969b410
│  │  ├─ 97
│  │  │  └─ 2c4f4d6e61ef7b04008eadfe51ae26a610685d
│  │  ├─ 98
│  │  │  └─ 5c045d131d1699ae74ad9ac9b9a476dc912531
│  │  ├─ 9a
│  │  │  └─ b7364d987e5b63da4c9bfe5840beb75493eca3
│  │  ├─ 9b
│  │  │  └─ e59b2c2d8e2ec5da5fccc1d2e83650c7949006
│  │  ├─ 9d
│  │  │  └─ 423a4aa942635ec6b435b395b34df3e4bd7a35
│  │  ├─ 9e
│  │  │  ├─ 0c251f10d10b55af5cebf697dc9f4f5ece2dfc
│  │  │  └─ 71d66485696a4880c03b3c8553001547b4e3e2
│  │  ├─ a2
│  │  │  ├─ 7616c3b00ab06f559da8cced2c40036feb64d9
│  │  │  └─ d755ff5d07f260ca34d90421b97231aa405d67
│  │  ├─ a3
│  │  │  └─ 2f3dbc4809ffd36c6ed954e67a7d6310154d0b
│  │  ├─ a4
│  │  │  ├─ 16600997dce752cf9f163cd8a9745ac427c85c
│  │  │  └─ 3e6e7182b13c4986e5cc021d4eee67b06b607b
│  │  ├─ a7
│  │  │  └─ 276e352b01a673c09177290afa37f35048696d
│  │  ├─ a8
│  │  │  ├─ 60845afbfa2e91b1d73f81bb9be3e3872b0ee5
│  │  │  └─ ea73508b0e3a26974a3d74c4fdc93927a4301c
│  │  ├─ a9
│  │  │  └─ d2d5ba3de157d75ac13ba321ea6a4284fdcb3f
│  │  ├─ aa
│  │  │  └─ cac67c38392b77d13b6648ca22cdc9975c19c9
│  │  ├─ ab
│  │  │  └─ 8f61e729b9f722d262f4dfb038552f0165d471
│  │  ├─ ad
│  │  │  ├─ 836101b6d57b3746ea2d403dbd31afaddfab7d
│  │  │  ├─ b44e326b08f4355bde5deae0d60487a7077ede
│  │  │  └─ e352f94933f9584ef9fa0c9515f0a682215bd5
│  │  ├─ b0
│  │  │  ├─ c634439d94e31a8de89f5b618dc2685bf24531
│  │  │  └─ e18a85991cf83c41cc96e607cbc4c79ebd8ee6
│  │  ├─ b2
│  │  │  └─ 5df26e1e6c42782b93f66cbf4a4dae26b8d27d
│  │  ├─ b5
│  │  │  └─ 9593d3650e3d682a07f927587c8353111d7827
│  │  ├─ b6
│  │  │  └─ d8961cd0eb5ff6385c515d04169f17af41374b
│  │  ├─ b8
│  │  │  ├─ a3af7e85435c868d15139c494e427607ceaf3b
│  │  │  └─ bf70c3272fd007cfe1e4f66a8abc8ddef5364c
│  │  ├─ bc
│  │  │  └─ 5e4b5a342013079f028387d01200a0b3746711
│  │  ├─ bf
│  │  │  └─ 5351426cc833755b0f7e198442295c627e7251
│  │  ├─ c1
│  │  │  └─ b145ae9027c397583d9a3714029c620a547c91
│  │  ├─ c3
│  │  │  └─ e863a32c24e306dbb762f5094efa3aba5b2706
│  │  ├─ c4
│  │  │  └─ 3a2a12d235efb39c4f8a86c6e09163f160b616
│  │  ├─ c5
│  │  │  └─ e3c1ee2c1a684a8ac9e1dbfc73983bc53fd7d2
│  │  ├─ c6
│  │  │  └─ 7c09b3474c6a8c5589173105978864c6ddfe74
│  │  ├─ cb
│  │  │  ├─ 89f7b5df1771d834ad9ace014a357a821f314b
│  │  │  └─ f1eb19e2c0d1d4d2ba712f719f98a2bcac0098
│  │  ├─ cc
│  │  │  └─ 8278764721d5a97d6178d3f50be8893de647be
│  │  ├─ ce
│  │  │  ├─ 7816907ab58166de78046605cda1bec70274e1
│  │  │  └─ 902cf79dc90d287813988f75efa4c91f7d93b3
│  │  ├─ cf
│  │  │  ├─ 6bbf2000d6a8dc5e6a9f63e2fd5371e1c3dd49
│  │  │  ├─ 71338e0fe9f14f8ffe66577a854aa67aa05448
│  │  │  └─ 9769a5741e8fb663e3f15f5d6d4dafd322e74e
│  │  ├─ d0
│  │  │  └─ a337d065b51f95a46dd50c72bc0eea0f975eb8
│  │  ├─ d2
│  │  │  └─ 35e031463828b64fada3308b934b46e352c734
│  │  ├─ d3
│  │  │  └─ 758676af8006845b1d5347c7b6de6bc4ec5697
│  │  ├─ d7
│  │  │  └─ 633bebf4502c378754d134811b9644e5bce265
│  │  ├─ d8
│  │  │  ├─ 5b4e6dc51eb568fe74226d4c908eb1508ba09c
│  │  │  └─ 6a1a45fe8d2e7100adb427aa1ad9e242dbb3d5
│  │  ├─ d9
│  │  │  ├─ a9e20f07a986cf05b0c33222c87ae747a016bd
│  │  │  ├─ d7e1eed472f7bfadbf4bf0b630f37d5ad5f9e9
│  │  │  └─ f91242108d477ab5cfafc282eb80ac7142e309
│  │  ├─ dd
│  │  │  └─ 501512386498924d730027a6c42f63da86ba77
│  │  ├─ de
│  │  │  ├─ 447688b7ee38a57dc2d0ebdc2e7dc369d58b39
│  │  │  └─ 82296caa0957a80f99617c84235d5de2711eca
│  │  ├─ df
│  │  │  └─ d7ab49851304e5f80ec768c4db4bd81cc9c4aa
│  │  ├─ e0
│  │  │  └─ 2e23ed5347dcc2923c0fa663f2a7ed4f709622
│  │  ├─ e2
│  │  │  ├─ 9c6b287d621285b4304c7cb7becb3de0a1aa59
│  │  │  └─ e3b69b952dec2ca4029f5dbbcb2f3460932178
│  │  ├─ e3
│  │  │  └─ 07fa7f1ca2f9039a9b4fddbb0ac128e43dcb1f
│  │  ├─ e4
│  │  │  └─ 8e6ca36a7aaa7f1f46940429728afd6c74b611
│  │  ├─ e5
│  │  │  └─ b5c13242b38f84784e8f5d56467700245c9608
│  │  ├─ e6
│  │  │  └─ 8b4c582b1b684dccdb1c098ecf8e80fbc3e3f0
│  │  ├─ e7
│  │  │  └─ d230ec59c3f9dd6cee0f3e717028ff524e6585
│  │  ├─ e8
│  │  │  └─ f4e0aeeba6b736257d04174c7279f3fb005959
│  │  ├─ eb
│  │  │  └─ 629cd2c77f141e146c275a215503566b9f1bf7
│  │  ├─ ed
│  │  │  ├─ 4301fd8a2f959440cc7333becbe6d0bce48db8
│  │  │  └─ 97d539c095cf1413af30cc23dea272095b97dd
│  │  ├─ ee
│  │  │  └─ d7b754490542f7cc6819f7c0017c27476505c1
│  │  ├─ f1
│  │  │  └─ fd59112c4bed174d67b69598f52c1956c10b32
│  │  ├─ f2
│  │  │  ├─ a9e99307896d44f94149805e32471af56c177d
│  │  │  └─ d3b7f1cf3b4bff791cd2d91a158abd980a13d7
│  │  ├─ f3
│  │  │  ├─ 0808d8dfabc8b57dc582ae8a668fdb72d40988
│  │  │  └─ d27357102035e5f33e07a38acff85ad9e00c63
│  │  ├─ f5
│  │  │  └─ e223c175d0aedcfad384b22fed31213229803e
│  │  ├─ f6
│  │  │  └─ a48aa5bed2ea1652305cf7dd9abb60f15fccb3
│  │  ├─ f7
│  │  │  └─ ca6fd58cf14e747d41f035bf2d037802944ec1
│  │  ├─ f9
│  │  │  ├─ 0cb0cf9dfae2bd74ded462c140300b4e6a6af7
│  │  │  └─ b93cffa12967821f067c6f414970f2b7926faa
│  │  ├─ fb
│  │  │  └─ 2817dbd6964a9a9a132be595ef71e50d55fdb0
│  │  ├─ fc
│  │  │  └─ 041b3816162604e441fb09c57031c9125f630f
│  │  ├─ ff
│  │  │  └─ 9ce4a67aa84f54df44929143b2761299de3b09
│  │  ├─ info
│  │  └─ pack
│  │     ├─ pack-d51ac89e7cae9f0918458bc50be16b8d4521a919.idx
│  │     ├─ pack-d51ac89e7cae9f0918458bc50be16b8d4521a919.pack
│  │     └─ pack-d51ac89e7cae9f0918458bc50be16b8d4521a919.rev
│  ├─ packed-refs
│  └─ refs
│     ├─ heads
│     │  ├─ main
│     │  └─ provision_vm_test
│     ├─ remotes
│     │  ├─ bardielle
│     │  │  ├─ main
│     │  │  └─ provision_vm
│     │  ├─ machacekondra
│     │  │  ├─ eebuild
│     │  │  ├─ fix_ci
│     │  │  ├─ main
│     │  │  └─ security
│     │  ├─ origin
│     │  │  ├─ HEAD
│     │  │  └─ main
│     │  └─ smiron
│     │     ├─ main
│     │     ├─ provision_vm
│     │     └─ provision_vm_test
│     └─ tags
├─ .github
│  └─ workflows
│     ├─ changelog.yaml
│     ├─ galaxy-import.yaml
│     ├─ linters.yaml
│     ├─ sanity-tests.yaml
│     └─ test.yml
├─ .gitignore
├─ .vscode
│  └─ extensions.json
├─ CHANGELOG.rst
├─ CODE_OF_CONDUCT.md
├─ CONTRIBUTING.md
├─ LICENSE
├─ MAINTAINERS
├─ Makefile
├─ README.md
├─ REVIEW_CHECKLIST.md
├─ changelogs
│  ├─ changelog.yaml
│  ├─ config.yaml
│  └─ fragments
│     └─ .keep
├─ codecov.yml
├─ docs
│  └─ docsite
│     └─ links.yml
├─ execution-environment
│  ├─ README.md
│  ├─ execution-environment.yml
│  └─ requirements.yml
├─ galaxy.yml
├─ meta
│  └─ runtime.yml
├─ playbooks
│  ├─ provision_vm
│  │  └─ manage_vm.yml
│  ├─ security.yml
│  └─ system_settings.yml
├─ plugins
│  └─ .gitkeep
├─ roles
│  ├─ provision_vm
│  │  ├─ README.md
│  │  └─ tasks
│  │     └─ main.yml
│  ├─ security
│  │  ├─ README.md
│  │  ├─ defaults
│  │  │  └─ main.yaml
│  │  └─ tasks
│  │     └─ main.yaml
│  └─ system_settings
│     ├─ README.md
│     ├─ defaults
│     │  └─ main.yml
│     └─ tasks
│        └─ main.yml
├─ tests
│  ├─ e2e
│  │  └─ molecule
│  │     ├─ README.MD
│  │     ├─ ansible.cfg
│  │     ├─ provision_vm
│  │     │  ├─ converge.yml
│  │     │  ├─ molecule.yml
│  │     │  ├─ post_validations
│  │     │  │  └─ verify_vm_post_provisioning.yml
│  │     │  ├─ scenarios
│  │     │  │  └─ basic_provision_vm.yml
│  │     │  ├─ testinfra
│  │     │  │  └─ sample_test.py
│  │     │  └─ vars
│  │     │     └─ vars.yml
│  │     └─ vault_files
│  │        └─ vsphere_creds.yml
│  ├─ expectations
│  │  └─ mock.json
│  ├─ integration
│  │  ├─ inventory
│  │  ├─ requirements.txt
│  │  ├─ requirements.yml
│  │  └─ targets
│  │     ├─ .gitkeep
│  │     ├─ init.sh
│  │     ├─ prepare_rest
│  │     │  └─ tasks
│  │     │     └─ main.yml
│  │     ├─ prepare_soap
│  │     │  └─ tasks
│  │     │     └─ main.yml
│  │     ├─ provision_vm_test
│  │     │  ├─ run.yml
│  │     │  ├─ runme.sh
│  │     │  └─ tasks
│  │     │     └─ main.yml
│  │     ├─ security_test
│  │     │  ├─ mock.json
│  │     │  ├─ run.yml
│  │     │  ├─ runme.sh
│  │     │  ├─ tasks
│  │     │  │  └─ main.yml
│  │     │  └─ vars.yml
│  │     └─ system_settings_test
│  │        ├─ mock.json
│  │        ├─ run.yml
│  │        ├─ runme.sh
│  │        ├─ tasks
│  │        │  └─ main.yml
│  │        └─ vars.yml
│  └─ units
│     └─ .gitkeep
└─ tox.ini

```