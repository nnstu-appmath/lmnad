# -*- coding: utf-8 -*-
# Generated by Django 1.9.12 on 2017-04-26 11:27
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('lmnad', '0016_auto_20170330_0935'),
    ]

    operations = [
        migrations.AlterField(
            model_name='event',
            name='date',
            field=models.DateTimeField(auto_now_add=True, verbose_name='\u0414\u0430\u0442\u0430 \u0438 \u0432\u0440\u0435\u043c\u044f'),
        ),
        migrations.AlterField(
            model_name='protection',
            name='date',
            field=models.DateField(auto_now_add=True, verbose_name='\u0414\u0430\u0442\u0430'),
        ),
        migrations.AlterField(
            model_name='seminar',
            name='date',
            field=models.DateTimeField(auto_now_add=True, verbose_name='\u0414\u0430\u0442\u0430 \u0438 \u0432\u0440\u0435\u043c\u044f'),
        ),
    ]