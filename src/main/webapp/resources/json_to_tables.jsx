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
    'PPI': 'Protein-Protein Interaction',
}

// Convert various file formats into the simple format we expect e.g. [[header_cell1, header_cell2], [row_1_cell_1, row_1_cell_2], ...]
const converters = {
    '.json': (file) => JSON.parse(fs.readFileSync(file, 'utf8')),
    '.csv': (file) => fs.readFileSync(file, 'utf8').split('\n').map((line) => line.split(',')),
    '.tsv': (file) => fs.readFileSync(file, 'utf8').split('\n').map((line) => line.split('\t')),
}

const icons = {
    '.sig': 'http://satie.bioinfo.cnio.es/themes/fustero/images/icon_6.png',
    '.gmt': 'https://s3.amazonaws.com/go-public/image/go-logo-icon.png',
    '.zip': 'https://cdn0.iconfinder.com/data/icons/document-file-types/512/zip-512.png',
    'pmid': 'http://www.ics-mci.fr/static/img/pubmed-icon.png',
}

// Visual column transformations. null will hide column
const transformers = {
    'Filename(s)': null,
    'URL': null,
    'Database': (row) => {
        if(row === undefined)
            return 'Database'
        else {
            return (
                <span style={{whiteSpace: "nowrap"}}>
                    {row['Database']}
                    {row['Filename(s)'].split(' ').map((file, ind) => {
                        const ext = '.' + file.split('.').pop()
                        return (
                            <a href={'datasets/' + row['Database'] + '/' + file} title={file} style={{paddingLeft: 5}} key={ind}>
                                <img src={icons[ext]} width={15} />
                            </a>
                        )
                    })}
                </span>
            )
        }
    },
    'Source PMID': (row) => {
        if(row === undefined)
            return 'PMID'
        else {
            return (
                <span style={{whiteSpace: "nowrap"}}>
                    {row['Source PMID'].split(';').map((pmid, ind) =>
                        <a href={'https://www.ncbi.nlm.nih.gov/pubmed/' + pmid} title={pmid} style={{paddingLeft: 5}} key={ind}>
                            <img src={icons['pmid']} width={25} />
                        </a>
                    )}
                </span>
            )
        }
    },
}

const col_data_to_records = (columns, data) => (
    data.map((row) => (
        row.reduce((record, cell, ind) => {
            const column = columns[ind]
            record[column] = cell
            return record
        }, {})
    ))
)

const records_to_col_data = (records) => ({
    columns: Object.keys(records[0]),
    data: records.map((record) => Object.keys(record).map((key) => record[key])),
})

const apply_transformers = (columns, data) => (
    records_to_col_data(
        col_data_to_records(columns, data).map((record) =>
            Object.keys(record).reduce((row, column) => {
                const transformer = transformers[column]
                if(transformer !== undefined) {
                    if(transformer !== null) {
                        const k = transformer()
                        const v = transformer(record)
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
)

const render_table = (json) => {
    let { columns, data } = apply_transformers(json[0], json.slice(1))
    return (
        <div className="table-responsive">
            <table className="table table-sm datatable">
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
}

const render = (json) => {
    return (
        <div className="row">
            {Object.keys(json).map((table, ind) =>
                <div className="col-sm-12" key={ind}>
                    <h6>{table_lookup[table]}</h6>
                    {render_table(json[table])}
                </div>
            )}
        </div>
    )
}

if(process.argv.length <= 3) {
    console.log('Usage: ' + process.argv[1] + ' <out.html> [blah.json blah.csv blah.tsv...]')
    process.exit(0)
}

const output = process.argv[2]
const json = process.argv.slice(3).reduce((json, file) => {
    const root = path.dirname(file)
    const ext = '.' + file.split('.').pop()
    const base = path.basename(file, ext)

    const converter = converters[ext]
    if(converter === undefined) throw new Error("Unknown file type")

    json[base] = converter(file)
    return json
}, {})

const rendered =
    '<%-- Do not edit this file directly. See README.md --%>\n' +
    pretty(ReactDOMServer.renderToStaticMarkup(render(json)))

fs.writeFileSync(output, rendered)
