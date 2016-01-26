+++
date = "2016-01-26T13:50:32+01:00"
draft = false
tags = ["cloud", "devops","presentation"]
title = "DevOps Kung-fu workshop"

+++

*Work in progress...*


I am now working on DevOps workshop that would show up Chef, Consul, Docker possibilities in DEV and orchestration together
with KitchenCI and InSpec testing and auditing.

As a first stage I created my own version for DevOps kung-fu presentation: http://slides.com/petrmichalec/epcim-devops-cult
{{< figure src="/media/post/2016/2016-01_DevOpsKungFu.png" title="DevOpsKungFu presentation" >}}
*Note: this was originaly presented by  Adam Jacob / CTO of Chef / @adamhjk - http://github.com/chef/devops-kungfu. Worth to watch youtube stream BTW.*


On the list I now have now many topics I got in touch in last year, some mentioned below I will publish here. The ones I already starter to work on:

- Writing Chef cookboks, including new chef resources introduced in 12.5.
  - Percona MySQL deployment with Chef & Consul in place.
  - Labs for Chef cookbooks deploying Apps to Node.js / WAS Liberty.
- Great "knife-zero" use-cases for server-less deployment.
- Desktop cross platform (win/lin/osx) configuration cookbook combining chef-zero, pantry cookbook, Policyfiles, BoxStarter, Chocolately
- Chef Policyfiles, Policy repos use-case examples to simplify one-shot deployments. *(PoC for avoiding roles/environments in this tech preview)*
- Server/InSpec environment audit controls & checks. (ie: integration testing)

I will update this post as more content will get online.
