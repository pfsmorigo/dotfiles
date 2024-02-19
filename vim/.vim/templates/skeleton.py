#!/usr/bin/env python3

# import dataclasses

# @dataclasses.dataclass(frozen=True, eq=True)
# class LPBase:
    # instance: lazr.restfulclient.resource.Entry
    # self_link: str
    # web_link: str
    # resource_type_link: str
    # http_etag: str

    # @classmethod
    # def parse(cls, instance: lazr.restfulclient.resource.Entry):
        # fields = [_.name for _ in dataclasses.fields(cls) if _.name != "instance"]
        # kwargs = {k: getattr(instance, k) for k in fields}
        # return cls(instance=instance, **kwargs)



