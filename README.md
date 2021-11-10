Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.
aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Update CHANGELOG.md

git show aefea


Какому тегу соответствует коммит 85024d3?
v0.12.23

git show 85024d3

Сколько родителей у коммита b8d720? Напишите их хеши.
2
56cd7859e 9ea88f22f

git show  --format=%p b8d720

Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

33ff1c03bb960b332be3af2e333462dde88b279e v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release

git log v0.12.23..v0.12.24 --pretty=oneline


Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

8c928e83589d90a031f811fae52a81be7153e82f

 git grep --heading -n 'func providerSource('
 git log --pretty=oneline  provider_source.go


Найдите все коммиты в которых была изменена функция globalPluginDirs.

66ebff90cdfaa6938f26f908c7ebad8d547fea17
41ab0aef7a0fe030e84018973a64135b11abcd70
52dbf94834cb970b510f2fba853a5b49ad9b1a46
78b12205587fe839f10d946ea3fdc06719decb05

git grep --heading -n 'globalPluginDirs'
git log -L :globalPluginDirs:plugins.go


Кто автор функции synchronizedWriters?

commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Wed May 3 16:25:41 2017 -0700

git log -S"func synchronizedWriters("











