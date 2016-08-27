FROM elasticsearch:1.5

MAINTAINER Modern Tribe

# install analysis plugins
RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.5.0 \
 && /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.5.0 \
 && /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-smartcn/2.5.0