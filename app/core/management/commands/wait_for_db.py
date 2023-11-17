"""
Django  command for making the app to wait for the database to start
"""
import time

from psycopg2 import OperationalError as Psycopg2Error

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """ comMand to make the application wait """

    def handle(self, *args, **options):
        self.stdout.write("Waiting for database.....")
        db_up = False
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg2Error, OperationalError):
                self.stdout.write('Database unavailable, waiting fo ne second')
                time.sleep(1)

        self.stdout.write("Database is available. :)")
