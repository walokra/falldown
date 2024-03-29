# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-falldown

# >> macros
%define __provides_exclude_from ^%{_datadir}/.*$
%define __requires_exclude ^libm.*$
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    Falldown is a game where you've to tilt your phone to make ball fall down
Version:    0.2.0
Release:    3
Group:      Amusements/Games
License:    GPLv3
URL:        https://github.com/walokra/falldown
Source0:    %{name}-%{version}.tar.bz2
Source100:  harbour-falldown.yaml
Requires:   sailfishsilica-qt5 >= 0.10.9
Requires:   qt5-qtmultimedia
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5DBus)
BuildRequires:  pkgconfig(Qt5Sensors)
BuildRequires:  pkgconfig(Qt5Multimedia)
BuildRequires:  mce-headers
BuildRequires:  desktop-file-utils

%description
Falldown is a cartoon game where you have to tilt your phone to make ball fall down quickly with rhythmic music. Don’t get squashed!


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5  \
    VERSION=%{version} \
    RELEASE=%{release}

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%defattr(0644,root,root,755)
%attr(0755,root,root) %{_bindir}
%{_bindir}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor
# >> files
# << files
