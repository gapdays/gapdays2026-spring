---
layout: page
title: Registration
registration_state: open
---

{% case page.registration_state %}
{% when 'notyet' %}
<p class="message">Registration will be open soon.</p>

{% when 'closed' %}
<p class="message">Registration is closed.</p>

{% when 'open' %}
<p class="message">Registration is open.</p>

In order to participate in this meeting, please register with us, even if you only
wish to join for parts of the meeting. If you plan to not attend all five days of the whole week, 
simply indicate this in the questions/remarks field of the registration form.

<!--### Talks
We are looking for more talks, so please <a href="mailto:{{site.email}}">contact us via email</a> and let us know if you would like to give a talk about your research! We welcome talks about computational mathematics research, which utilised GAP.
-->

### Talks
We will have some slots for contributed talks. You can indicated through the
registration form whether you would like to give a short talk about your
research on computational mathematics utilizing GAP! 

### Registration form
To register please use [this form](https://forms.gle/cigDvp4dMNpHjCJv5).


### On funding
<!-- We have some limited funding to support travel and accommodation costs
(partially or fully) for students and early-career researchers, and/or for those with caring responsibilities. 
If you do so, please send an email to <a href="mailto:{{site.email}}">{{site.email}}</a> containing the following information

- provide an estimate of much support you expect to need, and
- include a brief explanation of the aims you hope to achieve during
  your visit and, if applicable, whether and how your visit would be
  beneficial to the GAP system and community.

Initial decisions on whether we can grant support and how much will be made on or shortly after <b>31st&nbsp;July&nbsp;2025</b>. -->
The funding deadline has now passed.
<!-- We may be able to support later applications depending on the amount, so please don't hesitate to ask. -->

### Questions?

<p>
If you have any questions
regarding registration, or in general, feel free to
<a href="mailto:{{site.email}}">contact us via email</a>.
</p>

{% endcase %}
