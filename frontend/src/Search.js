import React, { Component } from "react";
import "./Search.css";

class Search extends Component {
  state = {
    searchValue: "",
    queryParam: "title",
    adHits: [],
    hits: []
  };

  handleOnChange = event => {
    this.setState({ searchValue: event.target.value });
  };

  handleSearch = () => {
    if (this.state.searchValue) {
      this.makeApiCall(this.state.searchValue);
    }
  };

  makeApiCall = searchInput => {
    const queryParam = this.state.queryParam;
    var searchUrl = `http://35.228.179.156:8881/content/_search?q=${queryParam}:${searchInput}`;
    var adsUrl = `http://35.228.179.156:8881/adverts/_search?q=keywords:${searchInput}`;

    fetch(adsUrl)
      .then(response => {
        return response.json();
      })
      .then(jsonData => {
        this.setState({ adHits: jsonData.hits.hits });
      });

    fetch(searchUrl)
      .then(response => {
        return response.json();
      })
      .then(jsonData => {
        this.setState({ hits: jsonData.hits.hits });

        if (this.state.hits.length === 0) {
          this.setState({ queryParam: "content" });
          this.makeApiCall(this.state.searchValue);
        }
      });
  };

  render() {
    return (
      <div id="main">
        <h1>Queen's Search Engine</h1>
        <input
          name="text"
          type="text"
          placeholder="search..."
          onChange={event => this.handleOnChange(event)}
          value={this.state.searchValue}
        />
        <div id="main">
          <button onClick={this.handleSearch}>QSE Search</button>
          {this.state.adHits !== 0 ? (
            <div className="results-container">
              {this.state.adHits.map((adHit, index) => (
                <div className="single-result" key={index}>
                  <b>Ad:</b>
                  {adHit._source.title}
                  <br />
                  <i>{adHit._source.description}</i>
                  <br />
                  <a href={adHit._source.url}>{adHit._source.url}</a>
                </div>
              ))}
            </div>
          ) : (
            <br />
          )}
          {this.state.hits !== 0 ? (
            <div className="results-container">
              {this.state.hits.map((hit, index) => (
                <div className="single-result" key={index}>
                  {hit._source.title}
                  <br />
                  <i>{hit._source.description}</i>
                  <br />
                  <a href={hit._source.url}>{hit._source.url}</a>
                </div>
              ))}
            </div>
          ) : (
            <p>No results found</p>
          )}
        </div>
      </div>
    );
  }
}

export default Search;
