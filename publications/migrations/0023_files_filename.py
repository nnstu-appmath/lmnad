# Generated by Django 2.0.12 on 2021-10-22 14:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('publications', '0022_journal_conf_checkbox'),
    ]

    operations = [
        migrations.AddField(
            model_name='files',
            name='filename',
            field=models.CharField(blank=True, max_length=255, verbose_name='Название файла'),
        ),
    ]
