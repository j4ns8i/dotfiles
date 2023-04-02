def docker_distro(distro):
    """Returns an upstream distro if possible if a downstream isn't supported"""
    distro = distro.lower()
    overrides = {'pop!_os': 'ubuntu'}
    return overrides.get(distro, distro)


class FilterModule(object):
    def filters(self):
        return {'docker_distro': docker_distro}
