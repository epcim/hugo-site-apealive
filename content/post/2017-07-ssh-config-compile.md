+++
date = "2017-07-05T10:31:07+02:00"
draft = false
title = "Generate your .ssh/config"
slug = "ssh-config-compile"
tags = ["blog","gist", "config", "openssh"]
+++

On ubuntu 16.04 is still an old version of OpenSSH client that don't support include
statement's on it's `.ssh/config`.

I manage my `dotfiles` in git repos and one such is `.ssh/config.d`. The script below is capable
take that repo as source and generate the configuration.

{{< gist epcim 3edef4ca7fdcc5237083c8942f7ee7a6 >}}
