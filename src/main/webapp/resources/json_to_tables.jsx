#!/usr/bin/env babel-node --presets env

import * as React from 'react'
import * as ReactDOMServer from 'react-dom/server'
import * as fs from 'fs'
import * as path from 'path'
import * as process from 'process'
import pretty from 'pretty'

// Convert abbreviated filenames into names to be displayed as table headers
const table_lookup = {
    'KINASE': 'Kinome Regulation',
    'TF': 'Transcriptional Regulation',
    'PPI': 'Protein-Protein Interactions',
};

// Convert various file formats into the simple format we expect e.g. [[header_cell1, header_cell2], [row_1_cell_1, row_1_cell_2], ...]
const converters = {
    '.json': (file) => JSON.parse(fs.readFileSync(file, 'utf8')),
    '.csv': (file) => fs.readFileSync(file, 'utf8').split('\n').map((line) => line.split(',')),
    '.tsv': (file) => fs.readFileSync(file, 'utf8').split('\n').map((line) => line.split('\t')),
};

const icons = {
    '.sig': 'http://satie.bioinfo.cnio.es/themes/fustero/images/icon_6.png',
    '.gmt': 'https://s3.amazonaws.com/go-public/image/go-logo-icon.png',
    '.zip': 'https://cdn0.iconfinder.com/data/icons/document-file-types/512/zip-512.png',
    'pmid': 'http://www.ics-mci.fr/static/img/pubmed-icon.png',
};

const display_url = (name, url) => {
    if(url === '')
        return name;
    else if(url === undefined)
        return null;
    else if(url[0] === '!') {
        return (
            <span dangerouslySetInnerHTML={{
                __html: url.slice(1).replace(/\[([^\]]+)\]\(([^\\)]+)\)/g, '<a href="$2">$1</a>')
            }} />
        )
    } else
        return (
            <a href={url}>{name}</a>
        )
};

const database_link = (table, database, file) => {
    return  'http://amp.pharm.mssm.edu/lincs-playground/index.php/s/kuUSjyFOryhTRDv/download?path='
        + encodeURIComponent('/' + table + '/' + database)
        + '&' + 'files=' + encodeURIComponent(file)
};

const trim = (str) => {
    return str.replace(/^\s+|\s+$/g, '')
};

// Visual column transformations. null will hide column
const transformers = {
    'Filename(s)': null,
    'URL': null,
    'Database': (row) => {
        if(row === undefined)
            return 'Database';
        else {
            return (
                <span style={{whiteSpace: "nowrap"}}>
                    {display_url(row['Database'], row['URL'])}
                </span>
            )
        }
    },
    'Filename(s)': (row, table) => {
        if(row === undefined)
            return 'Download';
        else {
            return (
                <span style={{whiteSpace: "nowrap"}}>
                    {row['Filename(s)'].split(' ').map((file, ind) => {
                        const ext = '.' + file.split('.').pop();
                        return (
                            <a
                                href={database_link(table, row['Database'], file)} title={file} style={{paddingLeft: 5}} key={ind}>
                                <svg viewBox="-5 -5 110 131" preserveAspectRatio="xMinYMin" style={{width:18,position:'relative',top:5}}>
                                    <path
                                        d="M0,0 l75,0 l25,25 l0,100 l-100,0 z"
                                        fill="lightgrey"
                                        stroke="black"
                                        strokeWidth="5"
                                    />
                                    <path
                                        d="M15,25 l60,0 M15,45 l70,0 M15,65 l70,0 M15,85 l70,0 M15,105 l70,0"
                                        fill="none"
                                        stroke="black"
                                        strokeWidth="3"
                                    />
                                    <path
                                        d="M5,75 l90,0 l0,45 l-90,0 z"
                                        fill="darkgrey"
                                        stroke="darkgrey"
                                        strokeWidth="5"
                                        opacity="0.75"
                                    />
                                    <g opacity="0.8">
                                        <path
                                        d="M30,10 l40,0 l0,45 l-40,0 z"
                                        fill="black"
                                        />
                                        <path
                                        d="M15,40 l70,0 l-35,35 z"
                                        fill="black"
                                        />
                                    </g>
                                    <text
                                        fontSize="3em"
                                        fontFamily="sans-serif"
                                        fill="black"
                                        textAnchor="middle"
                                        x="50"
                                        y="115"
                                        dx="0"
                                    >
                                        {ext.slice(1).toUpperCase()}
                                    </text>
                                </svg>
                            </a>
                        )
                    })}
                </span>
            )
        }
    },
    'Source PMID': (row) => {
        if(row === undefined)
            return 'PMID';
        else if(row['Source PMID'] !== '') {
            return (
                <span style={{whiteSpace: "nowrap"}}>
                    {row['Source PMID'].split(';').map(trim).map((pmid, ind) =>
                        <a href={'https://www.ncbi.nlm.nih.gov/pubmed/' + pmid} title={pmid} style={{paddingLeft: 5}} key={ind}>
                            <img src={icons['pmid']} width={25} />
                        </a>
                    )}
                </span>
            )
        }
    },
    'Interactions [Mouse]': (row) => {
        if(row === undefined)
            return 'Interactions [M/H]';
        else {
            if(row['Interactions [Mouse]'] === row['Interactions [Human]'])
                return row['Interactions [Mouse]'];
            else
                return row['Interactions [Mouse]'] + ' / ' + row['Interactions [Human]']
        }
    },
    'Interactions [Human]': null,
    'Unique Interactors [Mouse]': (row) => {
        if(row === undefined)
            return 'Interactors [M/H]';
        else {
            if(row['Unique Interactors [Mouse]'] === row['Unique Interactors [Human]'])
                return row['Unique Interactors [Mouse]'];
            else
                return row['Unique Interactors [Mouse]'] + ' / ' + row['Unique Interactors [Human]']
        }
    },
    'Unique Interactors [Human]': null,
    'Unique TFs [Mouse]': (row) => {
        if(row === undefined)
            return 'TFs [M/H]';
        else {
            if(row['Unique TFs [Mouse]'] === row['Unique TFs [Human]'])
                return row['Unique TFs [Mouse]'];
            else
                return row['Unique TFs [Mouse]'] + ' / ' + row['Unique TFs [Human]']
        }
    },
    'Unique TFs [Human]': null,
};

const col_data_to_records = (columns, data) => (
    data.map((row) => (
        row.reduce((record, cell, ind) => {
            const column = columns[ind];
            record[column] = cell;
            return record
        }, {})
    ))
);

const records_to_col_data = (records) => ({
    columns: Object.keys(records[0]),
    data: records.map((record) => Object.keys(record).map((key) => record[key])),
});

const apply_transformers = (columns, data, table) => (
    records_to_col_data(
        col_data_to_records(columns, data).map((record) =>
            Object.keys(record).reduce((row, column) => {
                const transformer = transformers[column];
                if(transformer !== undefined) {
                    if(transformer !== null) {
                        const k = transformer();
                        const v = transformer(record, table);
                        if(k !== null && v !== null)
                            row[k] = v
                    }
                } else {
                    row[column] = record[column]
                }
                return row
            }, {})
        )
    )
);

const render_table = (json, table) => {
    let { columns, data } = apply_transformers(json[0], json.slice(1), table);
    return (
        <div className="col-sm-12 my-3 table-responsive">
            <table className="display table table-striped table-bordered table-sm datasets">
                <thead>
                    <tr>
                    {columns.map((header, ind) =>
                        <th key={ind}>{header}</th>
                    )}
                    </tr>
                </thead>
                <tbody>
                    {data.map((row, ind) =>
                        <tr key={ind}>
                            {row.map((cell, ind) =>
                                <td key={ind}>{cell}</td>
                            )}
                        </tr>
                    )}
                </tbody>
            </table>
        </div>
    )
};

const render = (json) => {
    return (
        <div className="row">
            {Object.keys(json).map((table, ind) =>
                <div className="col-sm-12" key={ind}>
                    <h6>{table_lookup[table]}</h6>
                    {render_table(json[table], table)}
                </div>
            )}
        </div>
    )
};

if(process.argv.length <= 3) {
    console.log('Usage: ' + process.argv[1] + ' <out.html> [blah.json blah.csv blah.tsv...]');
    process.exit(0)
}

const output = process.argv[2];
const json = process.argv.slice(3).reduce((json, file) => {
    const root = path.dirname(file);
    const ext = '.' + file.split('.').pop();
    const base = path.basename(file, ext);

    const converter = converters[ext];
    if(converter === undefined) throw new Error("Unknown file type");

    json[base] = converter(file);
    return json
}, {});

const rendered =
    '<%-- Do not edit this file directly. See README.md --%>\n' +
    pretty(ReactDOMServer.renderToStaticMarkup(render(json)));

fs.writeFileSync(output, rendered);
