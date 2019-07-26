# Training

This training is designed as a two day hands-on training introducing Foreman.

In the training you will get basic knowlegde of the architecture of Foreman. You will
install and configure Foreman to provide several ways of provisioning. The configuration
management solution used is Puppet to show configuration management integration into Foreman.
Furthermore user and permission management of Foreman is shown. And last but not least
Foreman's extensibility is shown by introducing some plugins from basic ones to Katello.

Targeted audience are experienced Linux administrators in need of a provisioning and
management solution for their systems. Knowledgement of Puppet is of advantage but not
required.

## Online Material

In addition to the sources you can find the rendered material on 
[netways.github.io](https://netways.github.io/foreman-training)

* [Presentation](https://netways.github.io/foreman-training)
* [Handouts](https://github.com/NETWAYS/foreman-training/releases/download/v1.4/foreman-training-handouts.pdf)
* [Exercises](https://github.com/NETWAYS/foreman-training/releases/download/v1.4/foreman-training-exercises.pdf)
* [Solutions](https://github.com/NETWAYS/foreman-training/releases/download/v1.4/foreman-training-solutions.pdf)

## Provide your own training

Feel free to use this material as it is to provide your own training.

To run the presentation you will need [showoff 0.19.6](https://rubygems.org/gems/showoff/versions/0.19.6).
After installing you have to run the /global/wizard.sh script. It will give you some options how to start your presentation. You can switch between the serve and print mode.

For creating the rendered documents on your own run `showoff static print` (handouts),
`showoff static supplemental exercises` (exercises) or `showoff static supplemental solutions`
(solutions) followed by 
`wkhtmltopdf -s A5 --print-media-type --footer-left [page] --footer-right 'Foreman Training' static/index.html handouts.pdf`

If you want to change the design to represent your corporate identity have a look at 'foreman.css',
to change the included content adjust 'showoff.json' for example to add your own introduction as pre slides.

There will be optional content included in the training repository which does not fit in our
two day training, for example adding content about Docker integration is planed. This material
can be included in your training material by changing 'showoff.json', too. In the same way
remove content you do not want to show or change order if you feel it fits your need better.

For some notes on setting up the training enviroment have a look at 'Setup.md'.

If you provide a training we would be happy to add it to the forthcoming trainings to give you
some promotion on this site, simply contribute your date to the slides. In exchange we would like
you to credit us for providing the material.
In addition you can make sure to add it to the [events](http://theforeman.org/events/) listed by
the Foreman project.

# Contribution

Patches to fix mistakes or add optional content are always appreciated. If you want to see
changes on the default content of the training we are open for suggestions but keep in mind
that the training is intended for a two day hands-on training.

The rendered content will be updated at least if we do a newer version of the material which
will also be tagged on git.

Material is licensed under [Creative Commons Attribution-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-sa/4.0/).
