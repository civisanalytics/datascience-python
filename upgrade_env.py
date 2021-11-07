import json
import yaml
from urllib.request import urlopen
from urllib.error import HTTPError
import packaging.version

def newest_patch_version(package_name, version):
    version = packaging.version.parse(version)
    url = "https://pypi.org/pypi/%s/json" % (package_name,)
    try:
        data = json.load(urlopen(url))
        versions = [packaging.version.parse(r) for r in data["releases"].keys()]
        versions.sort(reverse=True)
        return [v for v in versions
                if not isinstance(v, packaging.version.LegacyVersion) and
                   version.major == v.major and
                   version.minor == v.minor][0]
    except (HTTPError, IndexError) as e:
        print(f"Error: {e}")
        return version

env = yaml.safe_load(open('environment.yml', 'r'))
new_dependencies = []
for package in env['dependencies']:
    if isinstance(package, dict):
        new_pip = []
        for pkg in package['pip']:
            name, version = pkg.split('==')
            print(name)
            print(version)
            new_version = newest_patch_version(name, version)
            print(new_version)
            new_pip.append(f'{name}=={new_version}')
        new_dependencies.append({'pip': new_pip})
        continue
    print(package)
    name, version = package.split('=')
    print(name)
    print(version)
    new_version = newest_patch_version(name, version)
    print(new_version)
    new_dependencies.append(f'{name}={new_version}')

env['dependencies'] = new_dependencies
with open('environment.yml', 'w') as f:
    yaml.dump(env, f)
